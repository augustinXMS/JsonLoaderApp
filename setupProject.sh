# sfdx force:auth:web:login -d -a DevHub
variable=$(sfdx force:org:create -f config/project-scratch-def.json --durationdays 1 | awk -v RS=" " '/username:/{getline;print $0}'| sed 's/.$//') 
echo $variable
sfdx force:config:set defaultusername=$variable
sfdx force:source:push   
sfdx force:org:open 