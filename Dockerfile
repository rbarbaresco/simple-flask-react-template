FROM python:3-alpine

RUN mkdir -p /usr/src/app/static
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

RUN apk add --update nodejs
WORKDIR /usr/src/app/static
COPY static/package.json /usr/src/app/static
RUN npm install

COPY . /usr/src/app
RUN npm run build

WORKDIR /usr/src/app

EXPOSE 5000

CMD [ "python", "./app.py" ]