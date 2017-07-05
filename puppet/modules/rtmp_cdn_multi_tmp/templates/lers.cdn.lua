-- Start of the configuration. This is the only node in the config file.
-- The rest of them are sub-nodes

local httpAcceptPort=9100+rtmpPort-1935
local httpLocalPortStart=9200
local httpLocalPort=httpLocalPortStart+rtmpPort-1935

configuration=
{
    -- if true, the server will run as a daemon.
    -- NOTE: all console appenders will be ignored if this is a daemon
    daemon=true,

    -- work process number   
    workprocess=6,
 
    -- port 
    rtmpPort=rtmpPort,
    httpAcceptPort=httpAcceptPort,
    httpLocalPort=httpLocalPort,
    httpLocalPortStart=httpLocalPortStart,
    
    -- the OS's path separator. Used in composing paths
    pathSeparator="/",

    -- Allow to publish stream, true by default
    rtmppushenable = false,
    rtmpcdnflag=true,
    
    -- Stream related intervals, 0 for not report
    read_report_interval = 60,
    write_report_interval = 60,
    instream_nodata_expire_time = 60,
    instream_unused_expire_time = 60,
	
    -- start play config
    -- rtmp_start_play_delay in seconds
    rtmp_start_play_delay = 5,
    rtmp_start_play_option = 2,

    -- Key frame cached duration in seconds
    key_frame_cached_duration = 10,

    -- Related configuration files
    AntiLeechConfigFile="/usr/local/etc/antileech.lua",

    -- standalone mode disables all authentications and service related reports
    -- false by default, for normal servers, and true for original media servers
    -- disabled fields include:
    -- rtmp2http, heartbeat, publishAuth, playAuth, streamEvent, streamPath,
    -- dynamicPull, streamResolution, and monitorreport
    standaloneMode = false,

    -- Nginx proxy configuration files
    proxy =
    {
        enable = true,
        exefile = "/usr/local/sbin/lers_proxy",
        configfile = "/usr/local/etc/lers_proxy.cdn.conf",
    },
	
	
    realp2p=
    {
        realP2PFlag=true,
        childStartUid=25,
        childUidNum=4,
    },
	
    -- RTMP to HTTP, or http + flv support
    rtmp2http =
    {
       enable = true,
       autoRestart = true,
       interval = 5,
       pidFile = "/var/run/r2h." .. httpAcceptPort .. ".pid",
       listen = "127.0.0.1",
       r2hlog = "/usr/local/rtmp/r2h/r2h_" .. httpAcceptPort,
       accesslog = "/usr/local/rtmp/r2h/access", 
       filenumsingleday = 10,
       maxonefile = 104857600,
       maxstreams = 1024,
       listhold = 128,
    },

    -- Interface with API Server
    ApiServer=
    {
        -- host = "http://115.182.51.77:8080/clive-api",
        host = "http://api.live.letvcloud.com",
        version = "v2",
        privateKey = "cce8c3ea9a2c389e9c2e95d728cd2bf9",
        interval = 20,
    },
    heartbeat=
    {
        enable=false,
        interval=10,
        url="/usernum/",
    },
    publishAuth =
    {
       enable = false,
       authUrlPrefix="/rtmp/pushStreamSecure",

       url = "/rtmp/checkStreamState",
       interval = 60,
    },
    playAuth =
    {
       enable = true,
       authUrlPrefix = "/rtmp/pullStreamSecure",
    },
    streamEvent  =
    {
       enable = true,
       apiServerPrefix = "/rtmp/streamStateChange",
    },
    dynamicPull =
    {
        -- %inurl for input URL, %name for stream name, and %dir for debug directory
        ffmpegCommand = "ffmpeg -re -i %inurl -codec copy -f flv rtmp://127.0.0.1/live/%name",
        FFREPORT = "file=%dir/%p-%t-%name.log:level=24",
    },
    streamResolution =
    {
        enable = true,
        prefix = "/rtmp/updateStreamWH",
    },
    PullStreamInfo =
    {
        enable = false,
        url = "/rtmp/getPullStreamInfoByIp",
    },

    -- Interface with GSLB
    streamPath =
    {
       enable = true,
       platId = "10",
       splatId = "1029",
       retryTimes = 100,
       gslbUrlPrefix = "http://cloud.live.g3proxy.lecloud.com/gslb?stream_id=",
    },

    -- UDT proxy
    udtproxy=
    {
        enable=false,
        proxyip="127.0.0.1",
        proxyport=9009,
    },

    -- Interface with nginx
    monitorreport=
    {
        enable=true,
        url="http://127.0.0.1/rtmp_connection?connections=%conn_num&push_num=%push_num&pull_num=%pull_num&interval=%interval&srcPort=" .. rtmpPort,
        interval=5,
        reportkey="ipmonitor",
    },

    -- Interface with statistics
    out_bandwidth_report=
    {
        enable=true,
        url="http://log.cdn.letvcloud.com/live_rtmp",
        interval=60,
    },
    clientAccessReport =
    {
        enable = true,
        timeFormat = "[%d/%b/%Y:%T %z]",
        url = "http://log.cdn.letvcloud.com/logreport/live/rtmpacc",
    },

    logAppenders=
    {
        --[[
        {
            -- name of the appender. Not too important, but is mandatory
            name="console appender",
            -- type of the appender. We can have the following values:
            -- console, coloredConsole and file
            -- NOTE: console appenders will be ignored if we run the server
            -- as a daemon
            type="coloredConsole",
            -- the level of logging. 6 is the FINEST message, 0 is FATAL message.
            -- The appender will "catch" all the messages below or equal to this level
            -- bigger the level, more messages are recorded
            level=6
        },
        --]]
        {
            name="debug",
            type="file",
            level=3,
            -- the file where the log messages are going to land
            fileName="/usr/local/rtmp/debug/" .. rtmpPort,
            --newLineCharacters="\r\n",
            fileHistorySize=10,
            fileLength=1024*1024*100,
            singleLine=false,
        },
        {
            name="access",
            type="file",
            level=3,
            fileName="/usr/local/rtmp/access/" .. rtmpPort,
            fileHistorySize=4,
            fileLength=1024*1024*100,
            singleLine=false,
        },
        {
           name = "statistic",
           type = "file",
           level = 6,
           fileName = "/usr/local/rtmp/" .. rtmpPort,
           fileHistorySize = 2,
           fileLength = 1024*1024*500,
           singleLine = true,
        },
    },

    -- this node holds all the RTMP applications
    applications=
    {
        -- this is the root directory of all applications
        -- usually this is relative to the binary execuable
        rootDirectory="applications",

        --this is where the applications array starts
        {
            name="appselector",
            description="Application for selecting the rest of the applications",
            protocol="dynamiclinklibrary",
            validateHandshake=false,
            default=true,
            acceptors =
            {
                {
                    ip="0.0.0.0",
                    port=rtmpPort,
                    protocol="inboundRtmp"
                },
                {
                   ip="127.0.0.1",
                   port=httpLocalPort,
                   protocol="inboundHttpReq"
                },
            }
        },
        {
            description="FLV Playback Sample",
            name="flvplayback",
            protocol="dynamiclinklibrary",
            mediaFolder="/letv/fet/rtmpmedia",
            rtmpUnsentDataMaxSize=1024*1024,
	    rtmpUnsentDataFlag=0,
            aliases=
            {
                "live",
                "oflaDemo",
            },

        },
    }
}
