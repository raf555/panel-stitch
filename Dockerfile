FROM node:22-alpine AS html-minifier
WORKDIR /app
COPY index.html .
RUN npx --yes html-minifier-terser@7.2.0 index.html \
	--collapse-whitespace \
	--minify-css \
	--minify-js \
	--remove-comments \
	--remove-redundant-attributes \
	--remove-script-type-attributes \
	--use-short-doctype \
	--output index.min.html

FROM nginx:alpine
COPY --from=html-minifier /app/index.min.html /usr/share/nginx/html/index.html
EXPOSE 80
