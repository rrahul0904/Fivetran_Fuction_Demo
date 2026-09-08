FROM nginx:1.27-alpine
COPY index.html /usr/share/nginx/html/index.html
RUN test "$(wc -c < /usr/share/nginx/html/index.html)" -gt 100000 \
 && grep -q "v11-git-static" /usr/share/nginx/html/index.html
EXPOSE 80
HEALTHCHECK --interval=10s --timeout=3s --start-period=3s --retries=3 CMD wget -qO- http://127.0.0.1/ | grep -q "v11-git-static" || exit 1
CMD ["nginx","-g","daemon off;"]
