# DOCKER TRAEFIK 2
alias network='docker-compose -f $HOME/docker/compose-files/network/network-compose.yml'
alias bittor='docker-compose -f $HOME/docker/compose-files/bittor/bittor-compose.yml'
alias database='docker-compose -f $HOME/docker/compose-files/database/database-compose.yml'
alias indexers='docker-compose -f $HOME/docker/compose-files/indexers/indexers-compose.yml'
alias management='docker-compose -f $HOME/docker/compose-files/management/management-compose.yml'
alias monitoring='docker-compose -f $HOME/docker/compose-files/monitoring/monitoring-compose.yml'
alias media='docker-compose -f $HOME/docker/compose-files/media/media-compose.yml'
alias other='docker-compose -f $HOME/docker/compose-files/other/other-compose.yml'
alias pvr='docker-compose -f $HOME/docker/compose-files/pvr/pvr-compose.yml'
alias security='docker-compose -f $HOME/docker/compose-files/security/security-compose.yml'
alias smarthome='docker-compose -f $HOME/docker/compose-files/smarthome/smarthome-compose.yml'
alias utility='docker-compose -f $HOME/docker/compose-files/utility/utility-compose.yml'

alias dclogs2='cd /home/$USER/docker ; docker-compose -f /home/$USER/docker/docker-compose.yml logs -tf --tail="50" '
alias dcup='network up -d; bittor up -d; database up -d; indexers up -d; management up -d; monitoring up -d; media up -d; other up -d; pvr up -d; security up -d; smarthome up -d; utility up -d; '
alias dcdown2='dcrun2 down'
alias dcrec='network up -d --force-recreate; bittor up -d --force-recreate; database up -d --force-recreate; indexers up -d --force-recreate; management up -d --force-recreate; monitoring up -d --force-recreate; media up -d --force-recreate; other up -d --force-recreate; pvr up -d --force-recreate; security up -d --force-recreate; smarthome up -d --force-recreate; utility up -d --force-recreate; '
alias dcstop2='dcrun2 stop'
alias dcrestart2='dcrun2 restart '
alias dcpull2='cd /home/$USER/docker ; docker-compose -f /home/$USER/docker/docker-compose.yml  pull'

# DOCKER TRAEFIK 2 VPN
alias dcrun2v='cd /home/$USER/docker ; docker-compose -f /home/$USER/docker/docker-compose-vpn.yml '
alias dclogs2v='cd /home/$USER/docker ; docker-compose -f /home/$USER/docker/docker-compose-vpn.yml logs -tf --tail="50" '
alias dcup2v='dcrun2v up -d'
alias dcdown2v='dcrun2v down'
alias dcrec2v='dcrun2v up -d --force-recreate'
alias dcstop2v='dcrun2v stop'
alias dcrestart2v='dcrun2v restart '
alias dcpull2v='cd /home/$USER/docker ; docker-compose -f /home/$USER/docker/docker-compose-vpn.yml  pull'