# Pi-Hole with Unbound DNS

<img src="pi-hole-logo.svg" width="150" height="260" alt="Pi-hole">

This repo contains everything needed to setup Pi-Hole with Unbound DNS. The result will be a very lean ad blocking/tracking blocking system protecting your whole network using Unbound to resolve DNS names without having to use any intermediate DNS services. This setup can easily be extended using [Wireguard and/or OpenVPN to be used when roaming](https://docs.pi-hole.net/guides/vpn/wireguard/server/).

### Requirements

Before starting the build make sure that:

- your RPi4 device has a static IP address;
- you have Docker installed on your RPi4;
- open `docker-compose.yaml` and replace the value for `WEBPASSWORD`. If this line is completely removed Pi-Hole will generate random password for you.

### Build

Build and start pihole-unbound:

- `docker-compose up -d`

Update home router to point to your RPi4 IP. Or, for testing purposes, setup only your machine to use Pi-Hole as DNS. It is good to have a secondary DNS setup too, if Pi-Hole is ever down (during an update, for example).

Open your RPi4 IP address on port 8090 and login with the password you've set in `docker-compose.yaml`. 

### Stop & Destroy

To stop and remove `pihole-unbound` setup run:

- `docker-compose down`

### Updating the system

Stop pihole-unbound:

- `docker-compose down`

Force rebuild (will update pihole base image as well as all the packages):

- `docker-compose up --build -d`

### Adlists

Here is a list of blockers used on my setup. I have picked them up from NextDNS and uBlock Origin after using them for a while. Some manual whitelisting will be necessary in the beginning. Remember, more is not better when it comes to block lists. 

- AdGuardSDNSFilter - `https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt`
- EasyList - `https://easylist.to/easylist/easylist.txt`
- EasyPrivacy - `https://easylist.to/easylist/easyprivacy.txt`
- FanBoy's Annoyance - `https://secure.fanboy.co.nz/fanboy-annoyance.txt`
- FanBoy's Social - `https://easylist.to/easylist/fanboy-social.txt`
- AdGuard Base - `https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_2_English/filter.txt`
- AdGuard Tracking - `https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_3_Spyware/filter.txt`
- AdGuard Mobile - `https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_11_Mobile/filter.txt`
- oisd - `https://dbl.oisd.nl`
- AdGuard Social media - `https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_4_Social/filter.txt`
- Frellwits Swedish Filter - `https://raw.githubusercontent.com/lassekongo83/Frellwits-filter-lists/master/Frellwits-Swedish-Filter.txt`
- GoodbyeAds - `https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Hosts/GoodbyeAds.txt`
- AdAway - `https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt`
- Energized Basic - `https://block.energized.pro/basic/formats/hosts.txt`
- Energised P0rn - `https://block.energized.pro/porn/formats/hosts.txt`
- Energized Ultimate - `https://block.energized.pro/ultimate/formats/hosts.txt`


### Updating the adlists

Once you have added lists to Pi-Hole using `Group Management --> Adlist` you need to  keep those lists up to date. Run the following command to achieve that:

```shell
docker exec pihole-unbound pihole updateGravity
```
Assumption here is that your docker container is called `pihole-unbound`. You can add this command to cronjob for regular updates. There is no need to run this command more than once in 2-3 days.