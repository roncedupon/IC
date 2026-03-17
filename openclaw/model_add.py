import json

with open('/home/dy/.openclaw/openclaw.json') as f:
    config = json.load(f)

# 添加百炼 provider
config['models']['providers']['bailian'] = {
    'baseUrl': 'https://dashscope.aliyuncs.com/compatible-mode/v1',
    'apiKey': 'sk-76ac9953ec60462984235ba2695a2409',
    'api': 'openai-completions',
    'models': [
        {
            'id': 'qwen-plus',
            'name': '通义千问Plus',
            'reasoning': False,
            'input': ['text'],
            'cost': {'input': 0, 'output': 0, 'cacheRead': 0, 'cacheWrite': 0},
            'contextWindow': 131072,
            'maxTokens': 8192
        }
    ]
}

# 添加别名
config['agents']['defaults']['models']['bailian/qwen-plus'] = {
    'alias': 'qwen-plus'
}

with open('/home/dy/.openclaw/openclaw.json', 'w') as f:
    json.dump(config, f, indent=2)

print('配置成功！')