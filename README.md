# Naver Cloud Platform terraform example

This example makes 1 VPC, 2 Private subnets, 2 Public subnets, 1 Server in Public subnet, 1 Login key.

This example doesn't make route table and something like that, so some resources use default one.

This example doesn't set server spec, so it depends on default value. When I made this code, that was `c2-g2-h50(vCPU 2EA, Memory 4GB, Disk 50GB)`.

## Prerequisite

1. eidt .env file

you can make new api key here: https://www.ncloud.com/mypage/manage/authkey

2. export .env

```sh
. ./export_envs.sh
env | grep NCLOUD # check
```

3. Provision

```sh
cd terraform
tf init # alias tf="terraform"
tf apply
```

4. Access

because I set init script, your server's password is `password` (if you use default variable)

```sh
echo $(tf output my_server_public_ip) # get ip
ssh root@$IP # password: "password"
```

<details>
<summary>deprecated way</summary>

```sh
eval "$(tf output my_key)" > key.pem
```

Than you can find root user password with ncloud console.

```sh
tf output my_server_public_ip # get MY_PUBLIC_IP
ssh root@$MY_PUBLIC_IP
```

</details>

5. Clean up

```sh
tf destroy
```

## Important lessons

-   It's recommended to use VPC mode instead of Classic mode
    -   For this, you should specify`support_vpc = "true"` in provider block
-   You can't change login key after server created
-   You can find server image code using some block (see `terraform/main.tf`)
-   You need to attach public ip and server in public subnet for external access
