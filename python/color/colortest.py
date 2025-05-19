def colored(text, color=None, on_color=None, style=None):
    """
    为字符串 text 添加 ANSI 颜色／样式。
    
    参数：
        color      : 前景色，支持 (black, red, green, yellow, blue, magenta, cyan, white)
        on_color   : 背景色，格式同 color，但前面加 “on_”，如 on_red, on_blue…
        style      : 文本样式，支持 (bold, dim, underline, reverse)
    返回：
        带 ANSI 转义码的字符串，打印时即带颜色／样式。
    """
    COLORS = {
        'black':   30, 'red':     31, 'green':   32, 'yellow':  33,
        'blue':    34, 'magenta': 35, 'cyan':    36, 'white':   37,
    }
    STYLES = {
        'bold':      1,
        'dim':       2,
        'underline': 4,
        'reverse':   7,
    }
    codes = []
    if style in STYLES:
        codes.append(str(STYLES[style]))
    if color in COLORS:
        codes.append(str(COLORS[color]))
    if on_color and on_color.startswith('on_'):
        bg = on_color[3:]
        if bg in COLORS:
            codes.append(str(COLORS[bg] + 10))
    if not codes:
        return text
    prefix = '\033[' + ';'.join(codes) + 'm'
    suffix = '\033[0m'
    return f"{prefix}{text}{suffix}"
print(colored("Hello, world!", color="red"))
print(colored("警告：出现错误！", color="yellow", on_color="on_black",style="bold"))
print(colored("Success", color="white", on_color="on_green"))
print(colored("Underlined text", style="reverse"))
