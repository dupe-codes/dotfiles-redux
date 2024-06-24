source "$HOME/scripts/utils/logging.sh"

tags=("drawing" "studying" "gamedeving" "coding" "writing")

start_date=$(date -d "last Monday" +%Y-%m-%d)
end_date=$(date -d "last Sunday" +%Y-%m-%d)

current_day=$(date +%u)
offset=$((current_day - 1))
end_date=$(date -d "$offset days ago" +%Y-%m-%d)

print_info "Generating timew reports for last week: $start_date to $end_date"

for tag in "${tags[@]}"; do
    echo ""
    print_info "$tag"
    timew summary from "$start_date" to "$end_date" "$tag"
done
