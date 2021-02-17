inotifywait -m /mnt/unionfs -e create -e delete -e moved_to |
    while read dir action file; do
        echo "The file '$file' in directory '$dir' via '$action'"
#        # do something with the file
    done
