


def create_trip (params)
    sql = "INSERT INTO trip_data (user_id, trip_name, start_date, end_date, trip_description, travel_buddy) VALUES ('#{USER_ID}','#{params[:trip_name]}','#{params[:start_date]}','#{params[:end_date]}','#{params[:trip_description]}','#{params[:buddy_email]}');"

# fix multiple buddy problem
    return run_sql(sql)
end
