git clone git@github.com:146BC/Rome.git rome
cp RomeKitTests/CI/seed.js rome/
cd rome
npm install
node seed.js
nohup node app.js &