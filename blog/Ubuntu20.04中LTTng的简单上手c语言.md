 本文基于[官方文档](https://lttng.org/docs/v2.11/#doc-ubuntu-ppa "官方文档")撰写。<br/>

### 一、安装LTTng Stable 2.11 PPA
 以下命令建议在root权限下进行`su root`。

 1. 添加 LTTng Stable 2.11 PPA 存储库并更新：
```shell
apt-add-repository ppa:lttng/stable-2.11
apt-get update
```

 2.  安装主要的 LTTng 2.11 软件包：
```shell
apt-get install lttng-tools
apt-get install lttng-modules-dkms
apt-get install liblttng-ust-dev
apt-get install liblttng-ctl-dev
```

 3.  如果需要检测和跟踪 Java 应用程序 和 Python 3 应用程序 ，可以安装 LTTng-UST Java 和 LTTng-UST Python 代理：
```shell
apt-get install liblttng-ust-agent-java
apt-get install python3-lttngust
```

### 二、简单的演示实例
 下面将介绍以下演示实例：
 
- 跟踪 Linux 内核 

- 跟踪C语言编写的用户应用程序 

- 查看和分析记录的事件 

 具体实现见下文。
 
### 三、跟踪 Linux 内核
 以下命令行需要 root 权限。
 
 1. 创建一个 跟踪会话 来写入其跟踪 到 `/tmp/my-kernel-trace`:
```shell
lttng create my-kernel-session --output=/tmp/my-kernel-trace
```
 
 2. 列出可用的内核跟踪点和系统调用：
```shell
lttng list --kernel
lttng list --kernel --syscall
```
 
 3. 创建 事件规则 与所需检测相匹配的 点名称，例如 sched_switch和 sched_process_fork 跟踪点，以及 open和 close 系统调用：
```shell
lttng enable-event --kernel sched_switch,sched_process_fork
lttng enable-event --kernel --syscall open,close
```
 还可以创建匹配 的事件规则 所有 Linux 内核 tracepoints（**注意：**这会在跟踪时产生大量数据）：
```shell
lttng enable-event --kernel --all
```
 
 4. 开始追踪 ：
```shell
lttng start
```
 
 5. 在你的系统上做一些操作几秒钟。 例如， 加载网站，或列出目录的文件。
 6. 摧毁LTTng跟踪会话：
```shell
lttng destroy
```

-  所述 [lttng destroy](https://lttng.org/man/1/lttng-destroy/v2.11 "lttng destroy") 命令不破坏跟踪数据; 它 只会破坏跟踪会话的状态。
- 所述 lttng destroy 命令也隐式运行 [lttng stop](https://lttng.org/man/1/lttng-stop/v2.11 "lttng stop") 命令 （请参阅 [启动和停止跟踪会话](https://lttng.org/docs/v2.11/#doc-basic-tracing-session-control "启动和停止跟踪会话") ）。 您需要停止跟踪以使 LTTng 刷新剩余的 跟踪数据并使跟踪可读。
 
### 四、跟踪用户应用程序 
 本节将通过跟踪用 C 语言编写的 Hello world 程序来演示简单的跟踪示例。

#### 4.1创建可跟踪的用户应用程序：
1. 创建跟踪点提供程序头文件，该`hello-tp.h`文件定义了 跟踪点和它们可以生成的事件：
```c
#undef TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER hello_world

#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./hello-tp.h"

#if !defined(_HELLO_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
#define _HELLO_TP_H

#include <lttng/tracepoint.h>

TRACEPOINT_EVENT(
    hello_world,
    my_first_tracepoint,
    TP_ARGS(
        int, my_integer_arg,
        char*, my_string_arg
    ),
    TP_FIELDS(
        ctf_string(my_string_field, my_string_arg)
        ctf_integer(int, my_integer_field, my_integer_arg)
    )
)

#endif /* _HELLO_TP_H */

#include <lttng/tracepoint-event.h>
```
 
2. 创建跟踪点提供程序包源文件 `hello-tp.c` ：
```c
#define TRACEPOINT_CREATE_PROBES
#define TRACEPOINT_DEFINE

#include "hello-tp.h"

```
 
3. 构建跟踪点提供程序包：
```shell
gcc -c -I. hello-tp.c
```
 
4. 创建 Hello World 应用程序源文件 `hello.c` ：
```c
#include <stdio.h>
#include "hello-tp.h"

int main(int argc, char *argv[])
{
    int x;

    puts("Hello, World!\nPress Enter to continue...");

    /*
     * The following getchar() call is only placed here for the purpose
     * of this demonstration, to pause the application in order for
     * you to have time to list its tracepoints. It is not
     * needed otherwise.
     */
    getchar();

    /*
     * A tracepoint() call. 一个 tracepoint() 调用。
     *
     * Arguments, as defined in hello-tp.h 参数，在 hello-tp.h 中定义：
     *
     * 1. Tracepoint provider name   (required)跟踪点提供程序名称（必需）
     * 2. Tracepoint name            (required)跟踪点名称（必需）
     * 3. my_integer_arg             (first user-defined argument)（第1个用户定义的参数）
     * 4. my_string_arg              (second user-defined argument)（第2个用户定义的参数）
     *
     * Notice the tracepoint provider and tracepoint names are
     * NOT strings: they are in fact parts of variables that the
     * macros in hello-tp.h create.注意这两个不是字符串，
	 * 他们是 hello-tp.h 宏定义创造的变量
     */
    tracepoint(hello_world, my_first_tracepoint, 23, "hi there!");

    for (x = 0; x < argc; ++x) {
        tracepoint(hello_world, my_first_tracepoint, x, argv[x]);
    }

    puts("Quitting now!");
    tracepoint(hello_world, my_first_tracepoint, x * x, "x^2");

    return 0;
}
```
 
5. 构建应用程序：
```shell
gcc -c hello.c
```
 
6. 将应用程序与跟踪点提供程序包 liblttng-ust 和 libdl 链接起来：
```shell
gcc -o hello hello.o hello-tp.o -llttng-ust -ldl
```
 
#### 4.2 构建过程示意图
[![用户空间跟踪教程的构建步骤](https://lttng.org/docs/v2.11/images/ust-flow.png "用户空间跟踪教程的构建步骤")](https://lttng.org/docs/v2.11/images/ust-flow.png "用户空间跟踪教程的构建步骤")
 
#### 4.3 跟踪用户应用程序：
1. 使用几个参数运行应用程序:
```shell
./hello world and beyond
```
 
  你会看见：
```shell
Hello, World!
Press Enter to continue...
```
 
2. 启动 LTTng [会话守护进程](https://lttng.org/docs/v2.11/#doc-lttng-sessiond "会话守护进程") ：
```shell
lttng-sessiond --daemonize
```
  请注意，会话守护程序可能已经在运行，例如 分发的服务管理器启动的服务。
 
3. 列出可用的用户空间跟踪点： 
```shell
lttng list --userspace
```
  你可以看见`./hello`程序下的`hello_world:my_first_tracepoint`跟踪点列表。
 
 4. 创建 [跟踪会话](https://lttng.org/docs/v2.11/#doc-tracing-session "跟踪会话") ：
```shell
lttng create my-user-space-session
```
 

5. 创建 [事件规则](https://lttng.org/docs/v2.11/#doc-event "事件规则") 匹配的 hello_world:my_first_tracepoint活动名称：
```shell
lttng enable-event --userspace hello_world:my_first_tracepoint
```
 
6. [开始追踪](https://lttng.org/docs/v2.11/#doc-basic-tracing-session-control "开始追踪") ：
```shell
lttng start
```
 
7. 回到运行中的 hello 应用程序，按 Enter。 这 程序执行所有 tracepoint()仪表点和出口。
 
8. 摧毁LTTng跟踪会话
```shell
lttng destroy
```

-  所述 [lttng destroy](https://lttng.org/man/1/lttng-destroy/v2.11 "lttng destroy") 命令不破坏跟踪数据; 它 只会破坏跟踪会话的状态。
- 所述 lttng destroy 命令也隐式运行 [lttng stop](https://lttng.org/man/1/lttng-stop/v2.11 "lttng stop") 命令 （请参阅 [启动和停止跟踪会话](https://lttng.org/docs/v2.11/#doc-basic-tracing-session-control "启动和停止跟踪会话") ）。 您需要停止跟踪以使 LTTng 刷新剩余的 跟踪数据并使跟踪可读。
- 默认情况下，LTTng 将跟踪保存在 `$LTTNG_HOME/lttng-traces/name-date-time` , 其中 `name`是跟踪会话名称。 如果没有设置 `LTTNG_HOME`环境变量默认为 `$HOME`。
 
>   请参阅下一步 **查看和分析记录的事件** 以查看记录的事件。

### 五、查看和分析记录的事件
  您可以使用许多工具来读取 LTTng 跟踪：

- `babeltrace`是一个命令行实用程序，它转换跟踪 格式； 它支持` LTTng `生成的格式、`CTF` 以及 可以是基本的文本输出 `grep` 等。 这 babeltrace命令 是 Babeltrace 项目的一部分
- Babeltrace 还包括 Python 3 绑定，所以受益于 Python 的强大功能，可以使用自己的脚本轻松打开和读取 LTTng 跟踪
- [Trace Compass ](http://tracecompass.org/ "Trace Compass ")是一个图形用户界面，用于查看和分析任何类型的 日志或跟踪，包括 LTTng。
- [LTTng analyses](https://github.com/lttng/lttng-analyses "LTTng analyses") 是一个 项目，其中包括对 LTTng 内核的许多高级分析 跟踪，如调度统计、中断频率分布、 最高 CPU 使用率等等。

> 注意： 本节假设 LTTng 保存了它记录的轨迹 在之前的教程中到它们的默认位置，在 `$LTTNG_HOME/lttng-traces`目录。 如果没有设置，该 LTTNG_HOME 环境变量默认为 $HOME。

#### 5.1 使用 babeltrace命令行工具
- 列出跟踪的所有记录事件的最简单方法是通过 它的路径
```shell
babeltrace ~/lttng-traces/my-user-space-session*
```
> babeltrace会在给定的路径中递归地找到所有的痕迹，并且 打印所有事件，按时间顺序合并。 
 
- 为进一步过滤，可以通过管道输出 `babeltrace` 到像 [grep](https://man7.org/linux/man-pages/man1/grep.1.html "grep") 的一个工具：
```shell
babeltrace /tmp/my-kernel-trace | grep _switch
```
 
- 可以通过管道输出 `babeltrace` 到像 [wc](https://man7.org/linux/man-pages/man1/wc.1.html "wc") 的一个工具来 统计记录的事件：
```shell
babeltrace /tmp/my-kernel-trace | grep _open | wc --lines
```
 

#### 5.2 使用 Babeltrace 1 Python bindings
  babeltrace可以通过使用 [grep](https://man7.org/linux/man-pages/man1/grep.1.html "grep") 和 类似的实用程序实现文本输出，是，更复杂的过滤器，例如只保留 字段值在特定范围内的事件记录是 使用 shell 编写并非易事。 此外，减少甚至 涉及多个事件记录的大多数基本计算都是虚拟的 无法实施。

  幸运的是，Babeltrace 1  Python 3 bindings 可以轻松地按顺序读取 LTTng 跟踪的事件记录 并计算所需的信息。

  以下脚本接受 LTTng Linux 内核跟踪路径作为其 第一个参数并打印前五个运行的短名称 在整个跟踪过程中 CPU 0 上的进程`top5proc.py`： 
```python
from collections import Counter
import babeltrace
import sys


def top5proc():
    if len(sys.argv) != 2:
        msg = 'Usage: python3 {} TRACEPATH'.format(sys.argv[0])
        print(msg, file=sys.stderr)
        return False

    # A trace collection contains one or more traces
    col = babeltrace.TraceCollection()

    # Add the trace provided by the user (LTTng traces always have
    # the 'ctf' format)
    if col.add_trace(sys.argv[1], 'ctf') is None:
        raise RuntimeError('Cannot add trace')

    # This counter dict contains execution times:
    #
    #   task command name -> total execution time (ns)
    exec_times = Counter()

    # This contains the last `sched_switch` timestamp
    last_ts = None

    # Iterate on events
    for event in col.events:
        # Keep only `sched_switch` events
        if event.name != 'sched_switch':
            continue

        # Keep only events which happened on CPU 0
        if event['cpu_id'] != 0:
            continue

        # Event timestamp
        cur_ts = event.timestamp

        if last_ts is None:
            # We start here
            last_ts = cur_ts

        # Previous task command (short) name
        prev_comm = event['prev_comm']

        # Initialize entry in our dict if not yet done
        if prev_comm not in exec_times:
            exec_times[prev_comm] = 0

        # Compute previous command execution time
        diff = cur_ts - last_ts

        # Update execution time of this command
        exec_times[prev_comm] += diff

        # Update last timestamp
        last_ts = cur_ts

    # Display top 5
    for name, ns in exec_times.most_common(5):
        s = ns / 1000000000
        print('{:20}{} s'.format(name, s))

    return True


if __name__ == '__main__':
    sys.exit(0 if top5proc() else 1)
```
 
  运行这个脚本： 
```shell
python3 top5proc.py /tmp/my-kernel-trace/kernel
```
 
  输出示例：
```shell
swapper/0           48.607245889 s
chromium            7.192738188 s
pavucontrol         0.709894415 s
Compositor          0.660867933 s
Xorg.bin            0.616753786 s
```
 
  请注意 swapper/0是Linux上CPU 0的“空闲”进程； 因为我们在跟踪时没有使用那么多 CPU，所以它的第一个 列表中的位置是有道理的。