#!/usr/bin/env python3
"""MiniMax API 简单测试"""
 
import os
import requests
 
api_key ="sk-76ac9953ec60462984235ba2695a2409"
 
# 简单的hello world请求
url = "https://api.minimax.chat/v1/chat/completions"
headers = {
    "Authorization": f"Bearer {api_key}",
    "Content-Type": "application/json"
}
payload = {
    "model": "MiniMax-M2.1",
    "messages": [{"role": "user", "content": "hello"}]
}
 
response = requests.post(url, headers=headers, json=payload)
print(f"状态码: {response.status_code}")
 
# 检查响应状态
if response.status_code == 200:
    print(f"回复: {response.json()['choices'][0]['message']['content']}")
else:
    # 打印错误详情
    print(f"错误响应: {response.text}")