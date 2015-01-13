server {
        listen 80;
        listen [::]:80;


        server_name example.com www.example.com;


        root /var/www/example.com/html;
        index index.html index.htm;


        location / {
            try_files $uri $uri/ =404;
        }
    }
