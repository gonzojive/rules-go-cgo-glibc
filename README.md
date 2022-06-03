## Demo of inconsistent rules_go cgo build between different machines

```shell
sudo docker run --rm $(sudo docker build -q -f Dockerfile.ubuntu1804 .) > output-ubuntu1804.txt
```

```shell
sudo docker run --rm $(sudo docker build -q -f Dockerfile.ubuntu2204 .) > output-ubuntu2204.txt
```

```shell
diff output-ubuntu1804.txt output-ubuntu2204.txt
```


To get a shell inside the container:

```shell
sudo docker run --rm --interactive --tty $(sudo docker build -q -f Dockerfile.ubuntu1804 .)
```


## Undesired behavior

On ubuntu 18.04, the output is

```
sha256sum bazel-out/k8-fastbuild/bin/program_/program:
d008634d2a4cee180ce1ab47a0ad5274964e76631590294ac72297746a95f5ff  bazel-out/k8-fastbuild/bin/program_/program
===========================
ldd --verbose bazel-out/k8-fastbuild/bin/program_/program:
        linux-vdso.so.1 (0x00007ffe94923000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f2d203bb000)
        libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f2d2019c000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f2d1fdab000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f2d20759000)

        Version information:
        bazel-out/k8-fastbuild/bin/program_/program:
                libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
                libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
                libpthread.so.0 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libpthread.so.0
                libm.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libm.so.6
        /lib/x86_64-linux-gnu/libm.so.6:
                ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
                libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_PRIVATE) => /lib/x86_64-linux-gnu/libc.so.6
        /lib/x86_64-linux-gnu/libpthread.so.0:
                ld-linux-x86-64.so.2 (GLIBC_2.2.5) => /lib64/ld-linux-x86-64.so.2
                ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
                libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_PRIVATE) => /lib/x86_64-linux-gnu/libc.so.6
        /lib/x86_64-linux-gnu/libc.so.6:
                ld-linux-x86-64.so.2 (GLIBC_2.3) => /lib64/ld-linux-x86-64.so.2
                ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
```

On 22.04:

```
sha256sum bazel-out/k8-fastbuild/bin/program_/program:
0963b7459542358503fb497962cd3bb28c02fb65c86c2324a22e52d9737afe3a  bazel-out/k8-fastbuild/bin/program_/program
===========================
ldd --verbose bazel-out/k8-fastbuild/bin/program_/program:
        linux-vdso.so.1 (0x00007ffeaed85000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f8b5dd53000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f8b5db2b000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f8b5de3f000)

        Version information:
        bazel-out/k8-fastbuild/bin/program_/program:
                libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_2.34) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_2.32) => /lib/x86_64-linux-gnu/libc.so.6
                libm.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libm.so.6
        /lib/x86_64-linux-gnu/libm.so.6:
                ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
                libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
                libc.so.6 (GLIBC_PRIVATE) => /lib/x86_64-linux-gnu/libc.so.6
        /lib/x86_64-linux-gnu/libc.so.6:
                ld-linux-x86-64.so.2 (GLIBC_2.2.5) => /lib64/ld-linux-x86-64.so.2
                ld-linux-x86-64.so.2 (GLIBC_2.3) => /lib64/ld-linux-x86-64.so.2
                ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
```


Diff:

`./gendiff.sh && cat report.diff` produces

```diff
2c2
< d008634d2a4cee180ce1ab47a0ad5274964e76631590294ac72297746a95f5ff  bazel-out/k8-fastbuild/bin/program_/program
---
> 0963b7459542358503fb497962cd3bb28c02fb65c86c2324a22e52d9737afe3a  bazel-out/k8-fastbuild/bin/program_/program
5,9c5,8
<       linux-vdso.so.1 (0x00007ffd799c0000)
<       libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f646a4f9000)
<       libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f646a2da000)
<       libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f6469ee9000)
<       /lib64/ld-linux-x86-64.so.2 (0x00007f646a897000)
---
>       linux-vdso.so.1 (0x00007ffd0ad37000)
>       libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f84fba7e000)
>       libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f84fb856000)
>       /lib64/ld-linux-x86-64.so.2 (0x00007f84fbb6a000)
14,15c13,15
<               libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
<               libpthread.so.0 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libpthread.so.0
---
>               libc.so.6 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libc.so.6
>               libc.so.6 (GLIBC_2.34) => /lib/x86_64-linux-gnu/libc.so.6
>               libc.so.6 (GLIBC_2.32) => /lib/x86_64-linux-gnu/libc.so.6
22,29d21
<       /lib/x86_64-linux-gnu/libpthread.so.0:
<               ld-linux-x86-64.so.2 (GLIBC_2.2.5) => /lib64/ld-linux-x86-64.so.2
<               ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
<               libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
<               libc.so.6 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libc.so.6
<               libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
<               libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
<               libc.so.6 (GLIBC_PRIVATE) => /lib/x86_64-linux-gnu/libc.so.6
30a23
>               ld-linux-x86-64.so.2 (GLIBC_2.2.5) => /lib64/ld-linux-x86-64.so.2
```