
def create_trip (params, user_id)
    return nil unless user_id
    sql = "INSERT INTO trip_data (lead_user_id, trip_name, start_date, end_date, trip_description) VALUES ('#{user_id}','#{params[:trip_name]}','#{params[:start_date]}','#{params[:end_date]}','#{params[:trip_description]}');"
# fix multiple buddy problem
    return run_sql(sql)
end

def find_trip_by_id (id)
    return nil unless id
    return run_sql("select * from trip_data where id = '#{id}';").first
end


def find_all_trips_from_user (lead_user_id)
    return nil unless lead_user_id
    trip_count = run_sql("SELECT COUNT(*) FROM trip_data where lead_user_id = #{lead_user_id};").first
    puts('TRIP COUNT BEFORE INDEXING')
    p(trip_count.values)
    puts("trip COUNT")
    p(trip_count.values[0])
    if trip_count.values[0].to_i == 0
        return []
    else 
        return run_sql("select * from trip_data where lead_user_id = #{lead_user_id};")
    end
end


def set_current_trip (current_trip_id)
    return nil unless current_trip_id
    return run_sql("update users set current_trip_id = '#{params[:id]}';")

end


def find_current_trip_data (user_id)
    @user = find_one_user(session[:user_id])
    if @user["current_trip_id"] == nil
        return @current_trip = []
      else
        current_trip_id = @user["current_trip_id"]
        return @current_trip = find_trip_by_id(current_trip_id)
    end
end

def update_trip (params)
    return run_sql("update trip_data set name = '#{params[:name]}', image_url ='#{params[:image_url]}' where id = #{params[:id]} where;")

end