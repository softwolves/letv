AntileechConfig=
{
    AntiLeech=
    {
        -- if no PrivateKey, use the default value
        PrivateKey="382238d39d12f1c3571cd06067502",
        RtmpKey="4303470fac3498789fedb32393847",
        Validity=60,

        -- if no enable, defaule value is false
        -- only enable for control MD5 comparision, not for IP
        enable=false,
    },
    WhiteIPRange =
    {
         -- {
         --    BeginIP = "10.58.0.0",
         --    EndIP   = "10.58.255.255",
         -- },
    },
    WhiteList=
    {
        {
            --"220.181.153.111",
            --"10.181.153.111",
        },
    },

    -- no authentication for publish or play
    WhiteStreamList =
    {
          "__rtmptest10m",
          "__rtmptest50m",
          "__rtmptest100m",
          "__publishtest1",
          "__publishtest2",
          "__publishtest3",
    },
}
