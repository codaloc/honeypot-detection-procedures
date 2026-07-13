
uname -s -v -n -m 2>/dev/null
/bin/uname -s -v -n -m 2>/dev/null
/usr/bin/uname -s -v -n -m 2>/dev/null
busybox uname -s -v -n -m 2>/dev/null
([ -f /proc/version ] && head -1 /proc/version | cut -d' ' -f1)
([ -f /etc/os-release ] && grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '\"')



uname -m 2>/dev/null
/bin/uname -m 2>/dev/null
/usr/bin/uname -m 2>/dev/null
busybox uname -m 2>/dev/null
([ -f /proc/cpuinfo ] && grep -q "lm" /proc/cpuinfo && echo x86_64)
([ -f /proc/cpuinfo ] && grep -q "CPU architecture: 8" /proc/cpuinfo && echo aarch64)
([ -f /proc/cpuinfo ] && grep -q "CPU architecture: 7" /proc/cpuinfo && echo armv7l)



cat /proc/uptime 2>/dev/null
busybox cat /proc/uptime 2>/dev/null



nproc 2>/dev/null
/usr/bin/nproc 2>/dev/null
busybox nproc 2>/dev/null
grep -c "^processor" /proc/cpuinfo 2>/dev/null


{
lscpu 2>/dev/null | awk -F: '/Model name/ {print $2}'
grep -m1 -E "^model name" /proc/cpuinfo 2>/dev/null | cut -d: -f2-
grep -m1 -E "^Hardware" /proc/cpuinfo 2>/dev/null | cut -d: -f2-
cat /proc/device-tree/model 2>/dev/null
} | sed '/^$/d; /unknown/d; s/^[[:space:]]*//; s/[[:space:]]*$//; s/ AArch64 Processor$//; s/ Processor$//; s/ CPU$//' | head -1