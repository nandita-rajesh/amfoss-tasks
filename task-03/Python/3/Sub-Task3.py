n = int(input("Enter a number: "))

for i in range(n-1):
    for j in range(i,n):
        print(" ",end="")
    for k in range(i):
        print("*",end="")
    for l in range(i+1):
        print("*",end="")
    print()
for a in range(n):
    for b in range(a+1):
        print(" ",end="")
    for c in range(a,n-1):
        print("*",end="")
    for d in range(a,n):
        print("*",end="")
    print()