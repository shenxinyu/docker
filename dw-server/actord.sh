#!/bin/sh

sleep 2
rm actord.lock
/root/actor/bin/actor.linux -log=/sgn/log/dw/actord.log -conf=/root/actor/etc/actord.cf
