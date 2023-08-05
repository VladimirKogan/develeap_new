# Start with an NGINX image
FROM nginx:stable-alpine

# Remove any existing static resources
RUN rm -rf /usr/share/nginx/html/*

# Copy the static HTML file to the NGINX server
COPY index.html /usr/share/nginx/html

# Expose the port NGINX is running on
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
