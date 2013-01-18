# Class: rsync
#
# This module manages rsync and provides a define for grabbing files via rsync
# It is included in the generic module for *ALL* nodes
#
class rsync {

    package { "rsync": }

    # Definition: rsync::get
    #
    # get files via rsync
    #
    # Parameters:   
    #   $source  - source to copy from
    #   $path    - path to copy to, defaults to $name
    #   $user    - username on remote system
    #   $purge   - if set, rsync will use '--delete'
    #   $exlude  - string to be excluded
    #   $keyfile - ssh key used to connect to remote host
    #   $timeout - timeout in seconds, defaults to 900
    #
    # Actions:
    #   get files via rsync
    #
    # Requires:
    #   $source must be set
    #
    # Sample Usage:

    $rsyncServer = "learn.localdomain"
    $rsync_path = "out"
    $src = "/dir"

    $target = "/tmp"

    $timeout ="900"

    $rsync_cmd ="rsync -atv rsync://$rsyncServer/$rsync_path$src $target"

        file { "/tmp" :
          ensure  => directory,
        }

        exec { $rsync_cmd :
            path    => ["/usr/bin/","/bin/","/sbin/","/usr/sbin/"],    
            timeout => $timeout,
        } # exec

        file { "$target$src" :
          recurse => true,
          owner   => thotruong,
          group   => thotruong,
          mode    => 755,
        }

} # class rsync
