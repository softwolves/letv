-- Start of the configuration. This is the only node in the config file.
-- The rest of them are sub-nodes
configuration=
{
    -- if true, the server will run as a daemon.
    -- NOTE: all console appenders will be ignored if this is a daemon
    daemon=true,

    -- the OS's path separator. Used in composing paths
    pathSeparator="/",

    -- read_report_interval = 10,
    write_report_interval = 60,
    ApiServerHostPrefix = "http://api.live.letv.com/v1/rtmp",
    heartbeat=
    {
        enable=true,
        interval=10,
        url="/usernum/",
    },
    publishAuth =
    {
       -- first time http://115.182.51.77:8080/rtmplive-api/v1/rtmp/pushStreamSecure
       enable= true,
       authUrlPrefix="/pushStreamSecure",

       -- http://${rtmpApiServer}/v1/rtmp/checkStreamState/
       url = "/checkStreamState/",
       interval = 60,
    },
    playAuth =
    {
       -- http://${rtmpApiServer}/v1/rtmp/pullStreamSecure/20131010121231/?tm=2014010112121&sign=mama1231sdf
       enable = true,
       authUrlPrefix = "/pullStreamSecure",
    },
    streamEvent  =
    {
       -- http://${rtmpApiServer}/v1/rtmp/streamStateChange/201313113131/1/
       enable = true,
       apiServerPrefix = "/streamStateChange",
    },
    streamPath =
    {
       -- http://live.gslb.letv.com/gslb?stream_id=hz_rtmptest_800&tag=live&platid=10&splatid=1080&format=2&expect=20&scheme=rtmp
       enable = true,
       platId = "10";
       splatId = "1029";
       gslbUrlPrefix = "http://live.gslb.letv.com/gslb?stream_id=",
    },
    --rtmppushenable=false,
    --instream_nodata_expire_time = 30,
    --instream_unused_expire_time = 60,
    udtproxy=
    {
        enable=false,
        proxyip="127.0.0.1",
        proxyport=9009,
    },
    monitorreport=
    {
        enable=true,
        url="http://127.0.0.1/rtmp_connection?connections",
        interval=30,
        reportkey="ipmonitor",
    },
    out_bandwidth_report=
    {
        enable=true,
        url="http://log.cdn.letvcloud.com/live/serverreport",
        --url="http://220.181.155.16/live/serverreport",
        interval=60,
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
            fileName="/usr/local/rtmp/debug",
            --newLineCharacters="\r\n",
            fileHistorySize=4,
            fileLength=1024*1024*100,
            singleLine=false,
        },
        {
            name="access",
            type="file",
            level=3,
            fileName="/usr/local/rtmp/access",
            fileHistorySize=4,
            fileLength=1024*1024*100,
            singleLine=false,
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
                    port=1935,
                    protocol="inboundRtmp"
                },
            }
        },
        {
            description="FLV Playback Sample",
            name="flvplayback",
            protocol="dynamiclinklibrary",
            --mediaFolder="/Volumes/Storage/TCIgnored/media",
            rtmpUnsentDataMaxSize=1024*1024,
            aliases=
            {
                "live",
                "oflaDemo",
            },
        },
    }
}
