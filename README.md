# Student management MYSQL set up 1 master, 2 slave with Docker 



## How to run
Move to source code directory and run

```bash
./build.sh
```

## Yêu cầu
Bạn cần có Docker để chạy script ở trên

Nếu chưa cài Docker, follow theo hướng dẫn ở đây: [Install Docker](https://docs.docker.com/engine/install/ubuntu/)

## Instruction

Khi chạy xong script, terminal sẽ hiển thị status của slave1 và slave2 và hiển thị message: Successfully

Tài khoản mysql:

Master: -u root -p root

Slave1: -u root -p slave

Slave2: -u root -p slave

Khi scripts chạy xong, truy cập vào Container master để thay đổi dữ liệu và truy cập vào Container Slave để hiển thị dữ liệu đã được backup từ master

Báo cáo: [Docs](https://docs.google.com/document/d/1VU6eTq5nKlVoa3BMnqvghxEw8amEMTUC1hgn2AnP0Nw/edit?usp=sharing)

