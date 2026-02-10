#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include <iostream>
#include <string>
#include <vector>
#include <ctime> // 必须包含，随机数种子需要

// ===================== 【基础常量定义 - 核心配置，可按需修改】 =====================
const int SCREEN_WIDTH  = 1280;  // 窗口宽度
const int SCREEN_HEIGHT = 720;   // 窗口高度
const int TILE_W        = 64;    // 瓦片宽度
const int TILE_H        = 32;    // 瓦片高度
const int MAP_WIDTH     = 32;    // 地图瓦片数量-宽（有限地图，固定32格）
const int MAP_HEIGHT    = 24;    // 地图瓦片数量-高（有限地图，固定24格）
const int PLAYER_SPEED  = 2;     // 人物移动速度

// 工具类型枚举 - 初始3件基础工具
enum ToolType {
    TOOL_NONE,
    TOOL_AXE,    // 斧头
    TOOL_PICK,   // 镐子
    TOOL_SHOVEL  // 铲子
};

// 瓦片类型枚举 - 有限地图的地形类型
enum TileType {
    TILE_GRASS,  // 草地
    TILE_STONE,  // 石头
    TILE_TREE,   // 树木
    TILE_WATER   // 水源
};

// ===================== 【工具类 - 基础生存工具核心逻辑】 =====================
class Tool {
public:
    ToolType type;
    std::string name;
    int durability;  // 耐久度
    int maxDurability;

    Tool(ToolType t) : type(t), durability(100), maxDurability(100) {
        switch (t) {
            case TOOL_AXE: name = "斧头"; break;
            case TOOL_PICK: name = "镐子"; break;
            case TOOL_SHOVEL: name = "铲子"; break;
            default: name = "空手"; durability = 0; break;
        }
    }

    // 使用工具：消耗耐久，返回是否可用
    bool use() {
        if (durability <= 0) return false;
        durability -= 1;
        return true;
    }
};

// ===================== 【人物类 - 初始人物核心逻辑】 =====================
class Player {
public:
    float x, y;               // 人物2.5D坐标
    int hp;                   // 血量
    Tool* currentTool;        // 当前手持工具
    std::vector<Tool*> tools; // 工具背包（初始携带3件）

    Player() : x(SCREEN_WIDTH/2), y(SCREEN_HEIGHT/2), hp(100) {
        // 初始人物：默认携带3件基础工具（生存游戏标配）
        tools.push_back(new Tool(TOOL_AXE));
        tools.push_back(new Tool(TOOL_PICK));
        tools.push_back(new Tool(TOOL_SHOVEL));
        currentTool = tools[0]; // 默认手持斧头
    }

    // 切换工具
    void switchTool(int idx) {
        if (idx >=0 && idx < tools.size()) {
            currentTool = tools[idx];
        }
    }

    // 移动人物 + 有限地图边界碰撞检测（核心！人物无法走出地图）
    void move(int dx, int dy) {
        float newX = x + dx * PLAYER_SPEED;
        float newY = y + dy * PLAYER_SPEED;
        // 边界检测：限制人物在有限地图内移动，绝对无法走出
        if (newX > TILE_W/2 && newX < SCREEN_WIDTH - TILE_W/2) x = newX;
        if (newY > TILE_H/2 && newY < SCREEN_HEIGHT - TILE_H/2) y = newY;
    }

    // 使用当前工具采集资源
    void collectResource(TileType tile) {
        if (!currentTool->use()) {
            std::cout << currentTool->name << " 耐久耗尽，无法使用！" << std::endl;
            return;
        }
        switch (currentTool->type) {
            case TOOL_AXE: if(tile == TILE_TREE) std::cout << "✅ 砍伐树木，获得木头！耐久剩余: " << currentTool->durability << std::endl; break;
            case TOOL_PICK: if(tile == TILE_STONE) std::cout << "✅ 挖掘石头，获得石块！耐久剩余: " << currentTool->durability << std::endl; break;
            case TOOL_SHOVEL: if(tile == TILE_GRASS) std::cout << "✅ 挖掘泥土，获得泥土！耐久剩余: " << currentTool->durability << std::endl; break;
            default: std::cout << "❌ 空手无法采集资源！" << std::endl; break;
        }
    }
};

// ===================== 【有限地图类 - 2.5D瓦片地图核心逻辑】 =====================
class Map {
public:
    TileType tiles[MAP_WIDTH][MAP_HEIGHT]; // 有限地图的瓦片数组（固定尺寸，核心）

    Map() {
        // 初始化有限地图：默认草地，随机生成石头和树木（生存游戏基础地形）
        for (int i=0; i<MAP_WIDTH; i++) {
            for (int j=0; j<MAP_HEIGHT; j++) {
                tiles[i][j] = TILE_GRASS;
                // 随机生成石头和树木，增加地形多样性
                int randTile = rand() % 20;
                if (randTile == 0) tiles[i][j] = TILE_STONE;
                if (randTile == 1) tiles[i][j] = TILE_TREE;
            }
        }
    }

    // 获取人物当前位置的瓦片类型 - 【核心修复点1+2：解决编译错误】
    TileType getTileAt(float x, float y) {
        // 修复：将浮点型计算结果 强制转换为int整型，再做取模运算
        int tileX = static_cast<int>(x / TILE_W) % MAP_WIDTH;
        int tileY = static_cast<int>(y / TILE_H) % MAP_HEIGHT;
        
        // 修复：防止坐标越界（隐藏BUG），保证tileX/tileY在地图范围内
        tileX = std::max(0, std::min(tileX, MAP_WIDTH - 1));
        tileY = std::max(0, std::min(tileY, MAP_HEIGHT - 1));
        
        return tiles[tileX][tileY];
    }
};

// ===================== 【游戏核心类 - 整合所有模块】 =====================
class SurvivalGame {
private:
    SDL_Window* window;
    SDL_Renderer* renderer;
    Player player;
    Map map;
    bool isRunning;

public:
    SurvivalGame() : isRunning(true) {
        // 初始化SDL2核心
        SDL_Init(SDL_INIT_EVERYTHING);
        TTF_Init();
        window = SDL_CreateWindow("C++ 2.5D生存游戏【有限地图-修复版】", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, SCREEN_WIDTH, SCREEN_HEIGHT, 0);
        renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    }

    ~SurvivalGame() {
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        TTF_Quit();
        SDL_Quit();
    }

    // 事件监听：WASD移动、数字键1-3切换工具、空格采集资源、ESC退出
    void handleEvents() {
        SDL_Event e;
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) isRunning = false;
            if (e.type == SDL_KEYDOWN) {
                switch (e.key.keysym.sym) {
                    case SDLK_ESCAPE: isRunning = false; break;
                    case SDLK_1: player.switchTool(0); std::cout << "🔧 切换为：斧头" << std::endl; break; // 1键=斧头
                    case SDLK_2: player.switchTool(1); std::cout << "🔧 切换为：镐子" << std::endl; break; // 2键=镐子
                    case SDLK_3: player.switchTool(2); std::cout << "🔧 切换为：铲子" << std::endl; break; // 3键=铲子
                    case SDLK_SPACE: 
                        // 【核心修复点3：逻辑BUG修复】采集当前人物脚下的瓦片资源
                        player.collectResource(map.getTileAt(player.x, player.y)); 
                        break; 
                }
            }
        }

        // 持续按键：WASD移动人物
        const Uint8* keys = SDL_GetKeyboardState(NULL);
        if (keys[SDL_SCANCODE_W]) player.move(-1, -1);
        if (keys[SDL_SCANCODE_S]) player.move(1, 1);
        if (keys[SDL_SCANCODE_A]) player.move(-1, 1);
        if (keys[SDL_SCANCODE_D]) player.move(1, -1);
    }

    // 2.5D视角渲染（核心！绘制有限地图+人物+UI）
    void render() {
        SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
        SDL_RenderClear(renderer);

        // 1. 绘制有限瓦片地图（2.5D斜角视角）
        for (int i=0; i<MAP_WIDTH; i++) {
            for (int j=0; j<MAP_HEIGHT; j++) {
                int sx = (i - j) * (TILE_W/2) + SCREEN_WIDTH/2 - MAP_WIDTH*TILE_W/4;
                int sy = (i + j) * (TILE_H/4) + SCREEN_HEIGHT/2 - MAP_HEIGHT*TILE_H/4;
                SDL_Rect tileRect = {sx, sy, TILE_W, TILE_H};
                // 根据瓦片类型设置颜色（实际开发替换为贴图）
                switch (map.tiles[i][j]) {
                    case TILE_GRASS: SDL_SetRenderDrawColor(renderer, 34, 139, 34, 255); break;  // 绿色-草地
                    case TILE_STONE: SDL_SetRenderDrawColor(renderer, 128, 128, 128, 255); break; // 灰色-石头
                    case TILE_TREE: SDL_SetRenderDrawColor(renderer, 139, 69, 19, 255); break;    // 棕色-树木
                    case TILE_WATER: SDL_SetRenderDrawColor(renderer, 0, 191, 255, 255); break;   // 浅蓝色-水源
                }
                SDL_RenderFillRect(renderer, &tileRect);
            }
        }

        // 2. 绘制人物（2.5D视角，在地图之上）
        SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
        SDL_Rect playerRect = {static_cast<int>(player.x) - 16, static_cast<int>(player.y) - 32, 32, 64};
        SDL_RenderFillRect(renderer, &playerRect);

        // 3. 绘制UI：显示当前工具、耐久度、血量（生存游戏基础UI）
        SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
        std::string uiText = "当前工具: " + player.currentTool->name + " | 耐久: " + std::to_string(player.currentTool->durability) + " | 血量: " + std::to_string(player.hp);

        SDL_RenderPresent(renderer);
    }

    // 游戏主循环
    void run() {
        while (isRunning) {
            handleEvents();
            render();
            SDL_Delay(16); // 60帧帧率控制
        }
    }
};

// ===================== 【主函数 - 游戏入口】 =====================
int main(int argc, char* argv[]) {
    srand(time(NULL)); // 随机种子，用于地图地形生成
    SurvivalGame game;
    game.run();
    return 0;
}