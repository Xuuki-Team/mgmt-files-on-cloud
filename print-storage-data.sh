# To transform the rclone output into the desired CSV format, you can use a bash script to parse the output 
# and generate the CSV. Here's a simple script to achieve that:                                             
                                                                                                           
#!/bin/bash                                                                                              
                                                                                                         
# Define the base path                                                                                   
base_path="vdrive:Source/Projects"                                                                       
                                                                                                         
# Initialize the CSV file with headers                                                                   
echo "project_name,session_date,vdrive_path" > $HOME/projects.csv                                              
                                                                                                         
# List directories in the base path                                                                      
echo "$base_path" 
projects=$(rclone lsd $base_path | awk '{print $5}')                                                     
                                                                                                         
# Iterate over each project                                                                              
for project in $projects; do                                                                             
    # List subdirectories for each project                                                               
    echo "$base_path/$project"
    sessions=$(rclone lsd "$base_path/$project" | awk '{print $5}')                                      
                                                                                                         
    # If there are no subdirectories, add the project itself                                             
    if [ -z "$sessions" ]; then                                                                          
        echo "$project,,${base_path}/" >> $HOME/projects.csv                                                   
    else                                                                                                 
        # Iterate over each session                                                                      
        for session in $sessions; do                                                                     
            echo "$project,$session,${base_path}/${project}/${session}/" >> $HOME/projects.csv                 
        done                                                                                             
    fi                                                                                                   
done                                                                                                     

# This script will generate a projects.csv file with the desired format. Make sure to have rclone installed 
# and configured properly to access your Google Drive. Adjust the base_path variable if your directory      
# structure changes.
