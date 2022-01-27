fuser /dev/video1 &> /dev/null && echo '' || fuser /dev/video2 &> /dev/null && echo '' || fuser /dev/video3 &> /dev/null && echo ''
