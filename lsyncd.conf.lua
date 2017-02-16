sync {
    default.rsync,
    source = "/home/teamspeak/teamspeak3-server_linux_amd64",
    target = "/home/teamspeak/backup",
    rsync = {
        archive  = true
    }
}
