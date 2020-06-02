#!/usr/bin/env python
# coding: utf-8

# In[1]:


from os import system


# In[2]:


def cmd():
    print('====================L-box=====================')
    print('\t 1. 安装Aria2Dash')
    print('\t 2. 安装WordPress')
    print('\t 3. 添加系统自动启动项')
    print('\t 0. 退出')
    print('====================L-box=====================')
    option = int(input('输入选项: '))
    if option == 1:
        system('rm -rf /tmp/lboxtmpsrc')
        system('wget https://github.com/Masterchiefm/Aria2Dash/raw/master/Aria2Dash.sh -O /tmp/lboxtmpsrc')
        cmd = '1'
        
    elif option == 2:
        system('rm -rf /tmp/lboxrmpsrc')
        system('wget https://raw.githubusercontent.com/Masterchiefm/L-box/master/install_wordpress.sh -O /tmp/lboxtmpsrc')
        cmd = '2'
        
    elif option == 3:
        system('rm -rf /tmp/lboxrmpsrc')
        system('wget  https://raw.githubusercontent.com/Masterchiefm/L-box/master/create_service.sh -O /tmp/lboxtmpsrc')
        cmd = '3'
    elif option == 0:
        cmd = '0'
    else:
        cmd = "echo 'WTF???'"
    return cmd 


# In[3]:


if __name__  == "__main__":
    a = True
    while a:
        CMD = cmd()
        if CMD == '0':
            a = False
        else:
            system('''bash /tmp/lboxtmpsrc''')
            system('rm -rf /tmp/lboxtmpsrc')


