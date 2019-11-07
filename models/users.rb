require 'bcrypt'


def find_user_by_email (email)
    return run_sql("select * from users where email = '#{email}';").first
end

def find_one_user (id)
    return nil unless id
    return run_sql("select * from users where id = '#{id}';").first
end

def create_user (params)
    password_digest = BCrypt::Password.create(params[:password])
    sql =  "INSERT INTO users (first_name, last_name, email, password_digest) VALUES ('#{params[:first_name]}', '#{params[:last_name]}', '#{params[:email]}', '#{password_digest}');"
    return run_sql(sql)
end 