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
 - 实际上，lua解释器通常会将你的每一行都视作一个块。如果它检测到你这一行不能形成一个块时，就会等待更多的输入或读取，直到形成一个完整的块。这造就了lua的灵活性
 - 官方文档中说明了一种在控制台执行多个文件的方法，-l。
  ```lua
  a文件：x=1
  b文件: print(x)

  lua -l a -l b
  --不过我估计我是不会用这种方法了，lua肯定会有包含文件的方法，到时候直接文件包含就行了
  ```

### 全局变量
 - lua的全局变量和python差不多，不需要声明，直接赋值就行；也不用删除，不用它就行。如果你非得删它。。。。好吧，你把它赋值nil就行了
  > a = nil --然后你就可以认为这个变量没了

### 一些符号约定
 - 首先，变量不能以数字开头,然后尽量不要下划线_接一个或多个大写字母，这个在lua中有特殊用途。
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
  a = print        --> 这个也可以
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
 - "::",是运算符中等级最高的运算符，它有三种作用：
  1. 全局作用：全局作用域，当全局变量在函数中，与某个局部变量重名，可以使用"::"来表示全局变量
  2. 类作用："类名::类中的成员名"
  3. 命名空间：

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

  polyline = {color="blue", thickness=2, npoints=4,
              {x=0,   y=0},
              {x=-10, y=0},
              {x=-10, y=1},
              {x=0,   y=1}
             }
  --感觉lua的表直接把python的字典和列表结合在了一起
  --上面的表，当你给它指定了key后，它就没有编号，后面的没有key的就会有依次排序的编号。就像这样：
  print (polyline[2].x) --> -10
  print (polyline.color) --> blue

  ```

### 语句
 - a, b = 10, 2*x 多个赋值
 - x, y = y, x 交换
 ```lua
 local a, b = 1, 10
 if a<b then
     print(a)   --> 1
     local a    -- `= nil' is implicit
     print(a)   --> nil
 end          -- ends the block started at `then'
 print(a,b)   -->  1   10
 ```
 - lua常常使用do-end来定界一个块，这个方法觉得挺好的。可以很方便的分清块的界限，以及更精细的控制一个或多个局部变量。
  ```
  do
      local a2 = 2*a
      local d = sqrt(b^2 - 4*a*c)
      x1 = (-b + d)/a2
      x2 = (-b - d)/a2
  end  -- 变量d和a2的范围在这里结束
  print(x1, x2)
  ```
 - lua条件循环语句大部分要用end结束的，除了语法要求以外，我觉得这也是非常清晰的告诉程序员以及lua解释器，一个语句块的界是哪里到哪里
 - 比如什么if-elseif-else-end，while-end, for-do-end
 - lua中使用repeat-until代替了C中的do-while，除了单词不一样，没什么区别
 - lua里面有两个常用的迭代函数：pairs()和ipairs()
  ```
  for i,v in ipairs(a) do print(v) end  -- 输出变量‘a’中所有的值
  for k in pairs(t) do print(k) end     -- 输出表‘t’中的所有键值
  ```
 - 这两个迭代器是很强大的，字符串，表，文件等几乎都可以用这两个函数迭代，方便，童叟无欺，谁用谁知道

### 函数
 - 函数也要用end结束
  ```
  function maximum (a)
    local mi = 1          -- 计数器
    local m = a[mi]       -- 值
    for i,val in ipairs(a) do
        if val > m then
            mi = i
            m = val
        end
    end
    return m, mi
  end                                                                               
  print(maximum({8,10,23,12,5}))     --> 23   3
  ```
 - lua中使用"..."作为不定参数来给函数使用，就是说参数没有规定要多少个，例如print函数的参数就是"..."
 - lua有个重命名文件的函数，rename
  ```lua
  rename(old="temp.lua", new="temp1.lua")
  ```
 - 定义函数的两种表达式
  ```lua
  function foo (x) return 2*x end
  foo = function (x) return 2*x end
  -- 这两个表达式是一样的，看个人习惯吧
  ```
 - 在lua的表库中提供了一个函数table.sort,这个函数可以接收一个表并对里面的元素进行排序,这个排序可以多种多样，升序或降序，数字或字母表，按键排序等，都可以.
  ```lua
  --这里写了一个小程序来说明这个东西
  network = {
      {name = "grauna",  IP = "210.26.30.34"},
      {name = "arraial", IP = "210.26.30.23"},
      {name = "lua",     IP = "210.26.23.12"},
      {name = "derain",  IP = "210.26.23.20"},
  }

  table.sort(network, function (a,b)
        return (a.name > b.name)
  end)

  for l,v in ipairs(network) do
    dcsdcaaOD print (v.name)
  end

  --输出结果
  arraial
  derain
  grauna
  lua
  ```
 - 其实，与上面这种sort类似的以另一个函数作为参数的函数就是常见的高阶函数。(当然，就我看来，高阶函数并没有什么太大的不同，也就叫法不一样= =)
 - 根据上面那些，写了一个lua的小游戏，关于寻路的，在game_FindRoome.lua里
 - lua中有专门的得到table大小的函数:table.getn(TableName),这个函数的前提条件是table的key必须有序，因为索引是从1开始的，否则会返回0
 - lua中关于抛出异常的函数是assert()，这个是很有用的，可以很好的定位出错
 - loadstring，用来从给定的字符串中得到块，它可以加载并运行一个给定的字符串(注意，是得到并运行一个块，而不是简单的读取字符串！！！)，常见的用法如下:
  ```lua
  assert(loadstring(script)) ()

  f = loadstring("a = 1")
  --上面的代码相当于
  f = loadstring("function() a = 1 end")
  ```
  ```lua
  -- 写个小程序更加清晰的说明loadstring
  f = loadstring("i = i + 1")
  i = 0
  f(); print(i)   --> 1
  f(); print(i)   --> 2

  print "enter function to be plotted (with variable `x'):"
  local l = io.read()
  local f = assert(loadstring("return " .. l))
  for i=1,10 do
      x = i   -- global `x' (to be visible from the chunk)
      print(string.rep("*", f()))
  end
  -- 打印10行，每行打印你输入数字多个“*”
  ```
 - 当然，还有一个loadfile的函数，就是简单的读取文件并执行
  ```lua
  function dofile (filename)
    local f = assert(loadfile(filename))
    return f()
  end
  ```

 - Lua提供了一个更高级的函数来加载和运行库，称为require。大致来说，require和dofile是一样的，但有两个重要的区别。
  1. 需要在路径中搜索文件
  2. 需要控制文件是否已经运行，以避免重复工作。由于这些特性，require是Lua中用于加载库的首选函数。
 - require使用的路径是模式列表，每个模式指定将虚拟文件名（要求的参数）转换为真实文件名的替代方法。例如，如果路径是
  ```lua
  ?; ?.lua; c:\windows\lili; /usr/local/lua/?/?.lua
  -- 那么调用需要“lili”会尝试打开以下文件：
  lili
  lili.lua
  c:\windows\lili
  /usr/local/lua/lili/lili.lua
  ```


### 迭代器
 -  自己写迭代器有两个常用的函数:string.find和string.sub,lua官方给出了一个简单的迭代器例子:
  ```lua
  function allwords ()
    local line = io.read() --首先录入输入的字符串
    local pos = 1 --计数器置1(前面说过，lua的表起始key不是0而是1)
    return function ()
        while line do
            local s, e = string.find(line, "%w+", pos) --从pos开始，即第一位开始查找字母数字。然后s、e返回为查到的起止key。
            if s then
                pos = e + 1 --当存在字母数字时，pos计数器计为止key+1
                return string.sub(line, s, e) --将查到的第一个key对应的元素返回，循环往复直到没有字母数字
            else
                line = io.read() --当迭代器将line遍历完后，重新输入，可以再次迭代返回
                pos = 1 --计数器重置
            end
        end
        return nil --当line为空，返回nil值
    end
  end
  ```
 - 上面的迭代器的缺点就是每次循环都会建立一个闭包，虽然这种资源消耗可以忽略，但是并不期望出现这种情况，为此，lua给出了泛型迭代
  ```lua
  --lua官方的泛型迭代格式:
  for <var-list> in <exp-list> do
      <body>
  end
  --其中<var-list>是一个或多个变量名称的列表，以逗号分隔，<exp-list>是一个或多个表达式的列表，也用逗号分隔。通常，表达式列表只有一个元素，即调用迭代器。
  --其实这个感觉是常用的格式，前面程序也有长这样的.
  ```

### 协同
 - 协同给我的感觉和线程差不多，就是多线程的概念；协同库表里面提供了所有的协同函数
 - 协同使用create函数创建新的协同程序(看吧，和多线程函数一样)
  ```lua
  co = coroutine.create(function ()
    print("hi")
    end)
  print(co)   --> thread: 0x8071d98
  ```
 - 一个协同程序有三种状态：运行、死亡、挂起。当我们使用create函数创建一个协同程序时，它处在挂起状态。
 - 当你要运行你创建的挂起的协同程序时，使用resume函数
 - 使用status函数查看一个协同程序的当前状态
 - 说句实话，上面的这些都没什么营养，和其他语言差不多。lua官方文档为了说明协同的不同和强大，重点说明了一个叫yield的函数，然后，我跟着看了一下。。。。其实就是可以将一个协同程序暂停并待会儿使用(这不还是和其他语言差不多吗。。。)
 - 协同一个经典的例子就是生产者和消费者问题
  ```lua
  function receive (prod)
    local status, value = coroutine.resume(prod)
    return value
  end

  function send (x)
    coroutine.yield(x)
  end

  function producer ()
    return coroutine.create(function ()
        while true do
            local x = io.read()     -- produce new value
            send(x)
        end
    end)
  end

  function filter (prod)
    return coroutine.create(function ()
        local line = 1
        while true do
            local x = receive(prod)   -- get new value
            x = string.format("%5d %s", line, x)
            send(x)      -- send it to consumer
            line = line + 1
        end
    end)
  end

  function consumer (prod)
    while true do
        local x = receive(prod)   -- get new value
        io.write(x, "\n")          -- consume new value
    end
  end

  p = producer()
  f = filter(p)
  consumer(f)
  ```
 - 也可以使用协同程序来写一个迭代器程序
  ```lua
  function permgen (a, n)
        if n == 0 then
            printResult(a)
        else
            for i=1,n do
                a[n], a[i] = a[i], a[n]
                permgen(a, n - 1)

                a[n], a[i] = a[i], a[n]

            end
        end
  end --这是一个将传入的字符排列组合的函数

  function perm (a)
        local n = table.getn(a)
        return coroutine.wrap(function () permgen(a, n) end)
  end

  for p in perm{"a", "b", "c"} do
      printResult(p)
  end
  ```
 - 上面用到了wrap这个函数，说一下,wrap和Create差不多，都是去创建一个coroutine,有些区别：
  1. wrap不会通过resume去得到第一个返回值(错误信息)
  2. 在创建完之后，直接调用函数，转到coroutine，而create却要resume才能转到coroutine。
  3. wrap不能查看状态。

<aside id="right"><h2>Lu0chen</h2></aside> 
