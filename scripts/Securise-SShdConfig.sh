################################################################
# Titre: Securation SSH des serveurs
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 09/11/2018 [RJ]
################################################################

# Install your ssh key in your server
mkdir /home/ravindra/.ssh
cat > /home/ravindra/.ssh/authorized_keys << EOF
ssh-rsa *YourRsaKey*
EOF
1
#On créer un backup avant de modifier notre conf
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
rm /etc/ssh/sshd_config

#Voir ma configuration actuel
#sudo sshd -T

sudo cat > /etc/ssh/sshd_config << EOF
#Connexion en root desactivé
PermitRootLogin no

#Nombre maximum de tentatives d'authentification pour une session de connexion particulière
MaxAuthTries 5

#Temps dont dispose un utilisateur pour terminer l'authentification après sa première connexion à votre serveur SSH
LoginGraceTime 20

#Connexion SSH uniquement avec clés SSH
PasswordAuthentication no

#Désactiver l'authentification avec des mots de passe vides
PermitEmptyPasswords no

#Désactiver affichage d'applications graphiques à distance via une connexion SSH
X11Forwarding no

#passer des variables d'environnement personnalisées
PermitUserEnvironment no

#Désactiver les tunnels SSH 
AllowAgentForwarding no
AllowTcpForwarding no
PermitTunnel no

#Désactiver la bannière SSH (trop d'informations sur votre système)
DebianBanner no

#Facultatif désactiver les autres méthodes d'authentification
ChallengeResponseAuthentication no
KerberosAuthentication no
GSSAPIAuthentication no
EOF

#Ne pas oublier de faire :
sudo service sshd reload
