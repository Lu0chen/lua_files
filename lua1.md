### 块
 - 在我看来，块是lua下的一段语句序列，它实现了一个特定的功能
 - 和python的很大区别是，lua对格式的要求非常小，甚至你用不用分号“；”都是无所谓的。比如下面四条语句都是正确并且等价的。
  ```lua
  a = 1
  b = a*2
  
  a = 1;
  b = a*2;
                      
  a = 1 ; b = a*2
  
  a = 1   b = a*2    --虽然很丑，却是正确的
  ```
 - 块给我的感觉就是很灵活，可以简单到“print ("Hello world")”,也可以大到一个块就几MB。强大的lua解释器对大尺寸的语句没有任何问题
 - 实际上，lua解释器通常会将你的没一行都视作一个块。如果它检测到你这一行不能形成一个块时，就会等待更多的输入或读取，直到形成一个完整的块。这造就了lua的灵活性
 - 官方文档中说明了一种在控制台执行多个文件的方法，-l。
  ```lua
  a文件：x=1
  b文件: print(x)

  lua -l a -l b
  --不过我估计我是不会用这种方法了，lua肯定会有包含文件的方法，到时候直接文件包含就行了
  ```

###　全局变量
 - lua的全局变量和python差不多，不需要声明，直接赋值就行；也不用删除，不用它就行。如果你非得删它。。。。好吧，你把它赋值nil就行了
  > a = nil --然后你就可以认为这个变量没了

### 一些符号约定
 - 首先，变量不能以数字开头,然后尽量不要下划线“_”接一个或多个大写字母，这个在lua中有特殊用途。
 - 你的变量甚至可以不是英文，“中文变量”、“índice”、“ação”。都可以，不过你的程序可能就不能在不支持变量语言的系统中运行了。
 - 然后，下面这些不能用：
  ```lua
    and       break     do        else      elseif
    end       false     for       function  if
    in        local     nil       not       or
    repeat    return    then      true      until
    while
  ```
 - 其他变量命名随意
 - lua对大小写敏感
 - 注释
  ```lua
  单行：--
  多行：--[[
        --]]
  ```

### 关于变量
 - 变量类型随意，真的随意
  ```lua
  print(type(a))   --> nil   (`a' is not initialized)
  a = 10
  print(type(a))   --> number
  a = "a string!!"
  print(type(a))   --> string
  a = print        --> 牛不牛批嘛，这个也可以
  a(type(a))       --> function
  ```
 - nil：这个以我现在的水平不怎么好解释，在lua中我觉得就是将nil作为一种非值，表示没有用的值
 - table：表类型实现了关联数组
  1. 关联数组是一个数组，不仅可以使用数字，还可以使用字符串或语言的任何其他值（nil除外）进行索引。
  2. 表是Lua中的主要（事实上，唯一的）数据结构机制，并且是一个强大的。我们使用表以简单，统一和高效的方式表示普通数组，符号表，集合，记录，队列和其他数据结构。 
  3. Lua使用表来表示软件包。当我们写io.read时，我们的意思是“从io包读取的条目”。对于Lua，这意味着“使用字符串”read“作为键”索引表io。
  4. Lua中的表既不是值也不是变量;他们是对象。你可以认为表是动态分配的对象;你的程序只操纵它们的引用（或指针）
  5. 你不必在Lua中声明一个表;事实上，没有办法宣布一个。您可以通过构造函数表达式创建表，其最简单的形式是{}：
   ```lua
   a = {}     -- 创建一个表并将其引用存储在“a”
   k = "x"
   a[k] = 10        -- 新的条目，key="x" and value=10
   a[20] = "great"  -- 新的条目, key=20 and value="great"
   print(a["x"])    --> 10
   k = 20
   print(a[k])      --> "great"
   a["x"] = a["x"] + 1 
   print(a["x"])    --> 11
   ```

### 关于运算符
 - lua里面的不等于不是"!=", 而是"~="
 - 当然，和其他语言差不多，比较变量的时候注意类型
  ```lua
  "0" = 0 --是错的
  "2" < "15" --是错的
  ```
 - 关于 and 和 or,其实感觉和其他语言差不多
  ```lua
  print(4 and 5)         --> 5
  print(nil and 13)      --> nil
  print(false and 13)    --> false
  print(4 or 5)          --> 4
  print(false or 5)      --> 5
  ```
 - lua中的连接符是".."
  ```lua
  print("Hello " .. "World")  --> Hello World
  print(0 .. 1)               --> 01
  a = "Hello"
  print(a .. " World")        --> Hello World
  print(a)                    --> Hello

  ```

### lua的表
 - lua的表有一个和其他语言很大的一个区别：
  ```lua
   days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
   print (days[0]) --> nil,居然会是空值
   print (days[1]) --> Monday，它的第一个元素的序号不是0，而是1
  ```
 - 当然，lua的表的初始化以及赋值是很灵活的:
  ```lua
  a = {x=0, y=0}
  a = {}; a.x=0; a.y=0 -->这两个是一样的，有点像python的字典不是吗，不过你可以随时进行任意操作
  --当然，还有其他的灵活运用
  w = {x=0, y=0, label="console"}
  x = {sin(0), sin(1), sin(2)}
  w[1] = "another field"
  x.f = w
  print(w["x"])   --> 0
  print(w[1])     --> another field
  print(x.f[1])   --> another field
  w.x = nil       -- remove field "x"
  ```









