export U=$(id -un)
export H=$(hostname -s)
export M=$(cat /etc/machine-id | head -c 16)
export T=$(date -u +%Y-%m-%dT%H:%M:%SZ)
export E=$(date +%s)


# Compile commands
riscv64-unknown-elf-gcc -O0 -g -march=rv64imac -mabi=lp64 -D"USERNAME=\"$U\"" -D"HOSTNAME=\"$H\"" -D"MACHINE_ID=\"$M\"" -D"BUILD_UTC=\"$T\"" -D"BUILD_EPOCH=$E" bubble_sort.c -o bubble_sort
spike pk bubble_sort >> outputs.txt


# Assembly commands
riscv64-unknown-elf-gcc -O0 -S bubble_sort.c -o bubble_sort.s 
riscv64-unknown-elf-objdump -d ./bubble_sort | sed -n '/<main>:/,/^$/p' | tee bubble_sort_main_objdump.txt
