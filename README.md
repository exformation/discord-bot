This can be run with `nix run` and by having a `.env` file containing your discord bot token. 

If you have just the `.env` file you can run it without cloning by using `nix run github:exformation/discord-bot`.  

I use this as a startup service by defining this repo as an input: 
```nix
discord-bot = {
    url = "github:exformation/discord-bot";
    inputs.nixpkgs.follows = "nixpkgs";
};
```
and then using the following systemd service: 
```nix
systemd.services.discord-bot = {
    description = "Discord Bot";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
        User = user;
        WorkingDirectory = "/home/${user}/repos/discord-bot";
        ExecStart = lib.getExe discord-bot.packages.${pkgs.system}.default;
    };
};
```

This bot is just a personal one for posting magic cards. It's not very useful for anyone else. 
