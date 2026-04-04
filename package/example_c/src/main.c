#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <syslog.h>

#define logerr(fmt, args...)  \
syslog(LOG_ERR|LOG_USER,"[%s](%d)" fmt , __func__, __LINE__, ## args)
#define loginfo(fmt, args...)  \
syslog(LOG_INFO|LOG_USER,"[%s](%d)" fmt , __func__, __LINE__, ## args)

int main(int argc, char **argv)
{
    while (1)
    {
        printf("run example_c!!!\n");
        loginfo("run example_c!!!\n");
        sleep(1);
    }

    return 0;
}