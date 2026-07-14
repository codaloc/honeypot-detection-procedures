# honeypot/VM detection proceduces
## Collected from automated linux scanners via cowrie ssh honeypot

### OS detection
uname
```sh
uname -s -v -n -m 2>/dev/null
/bin/uname -s -v -n -m 2>/dev/null
/usr/bin/uname -s -v -n -m 2>/dev/null
busybox uname -s -v -n -m 2>/dev/null
# Linux ov-579412 #1 SMP PREEMPT_DYNAMIC Debian 6.12.90-2 (2026-05-27) x86_64
```

reading system info files
```bash
# gets os
[ -f /proc/version ] && head -1 /proc/version | cut -d' ' -f1
# Linux

# gets distribution
[ -f /etc/os-release ] && grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '\"'
# debian

```

### Architecture detection
uname
```bash
uname -m 2>/dev/null
/bin/uname -m 2>/dev/null
/usr/bin/uname -m 2>/dev/null
busybox uname -m 2>/dev/null
# x86_64
```
system information files
```bash
([ -f /proc/cpuinfo ] && grep -q "lm" /proc/cpuinfo && echo x86_64)
[ -f /proc/cpuinfo ] && grep -q "CPU architecture: 8" /proc/cpuinfo && echo aarch64
([ -f /proc/cpuinfo ] && grep -q "CPU architecture: 7" /proc/cpuinfo && echo armv7l)
# x86_64
```

### Uptime tracking
system information files
```bash
cat /proc/uptime 2>/dev/null
busybox cat /proc/uptime 2>/dev/null
```

### Hardware detection
CPU cores number
```bash
nproc 2>/dev/null
/usr/bin/nproc 2>/dev/null
busybox nproc 2>/dev/null
grep -c "^processor" /proc/cpuinfo 2>/dev/null
# 2
```
CPU Names
```bash
lscpu 2>/dev/null | awk -F: '/Model name/ {print $2}'
grep -m1 -E "^model name" /proc/cpuinfo 2>/dev/null | cut -d: -f2-
grep -m1 -E "^Hardware" /proc/cpuinfo 2>/dev/null | cut -d: -f2-
cat /proc/device-tree/model 2>/dev/null
#cleanup:
sed '/^$/d; /unknown/d; s/^[[:space:]]*//; s/[[:space:]]*$//; s/ AArch64 Processor$//; s/ Processor$//; s/ CPU$//' | head -1
```


### Error behaviour detection
error outputs
```bash
# path error
(./xxxxxx 2>&1 || true)

# command error (via PATH)
(xxxxxx 2>&1 || true)

# test for executable creation
bash -c 'printf "#!/bin/bash\n echo \"xxxxxx\"\n" > filter && chmod +x filter && ./filter && rm -rf filter' 2>&1

# post-processing (max 250 char, remove trailing \n)
| (head -c 250 2>/dev/null || busybox head -c 250 2>/dev/null || dd bs=250 count=1 2>/dev/null) | (tr -d '\\n' 2>/dev/null || busybox tr -d '\\n' 2>/dev/null || cat)
```


### misc
```bash
#forces error message to be in english
```bash
export LANG=C LC_ALL=C
```

## Offending IP(s):
```
54  195.178.110.232
9   2.57.122.168
49  80.94.92.179
133 80.94.92.234
26  86.193.85.247
1   91.92.40.176
10  91.92.40.231
44  91.92.40.237
21  91.92.40.5
1   91.92.40.7
34  92.118.39.49
6   92.118.39.50
83  92.118.39.71
139 92.118.39.77
```

> collected over the span of two day.