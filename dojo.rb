require "test/unit"

class BuildQuery
	def search_user(params=nil)
		if params

			where = "where ";
			first_clause = true;

			params.each do |key, value|
			 	if !first_clause
			 		where += " and "
			 	end

			 	value.gsub! "'", "\\\\'"
			 	where += key.to_s + " = '" + value.to_s + "'"

			 	first_clause = false
			end

			query = "select * from user " + where + ";"
			puts query
			return query
		else
			query = "select * from user;"
			puts query
			return query
		end

		
	end
	
end

class TestBuildQuery < Test::Unit::TestCase
	def test_search_user_no_param
		query = BuildQuery.new
		expected = "select * from user;"
		result = query.search_user
		assert_equal(expected, result)
	end

	def test_search_user_name
		query = BuildQuery.new
		param_name = "manoel"
		expected = "select * from user where name = '#{ param_name }';"
		result = query.search_user :name => param_name
		assert_equal(expected, result)
	end

	def test_search_user_security_name
		query = BuildQuery.new
		param_name_hack = "manoel'; Drop Table user; --"
		param_name = "manoel\\'; Drop Table user; --"
		expected = "select * from user where name = '#{ param_name }';"
		result = query.search_user :name => param_name_hack
		assert_equal(expected, result)
	end

	def test_search_user_email
		query = BuildQuery.new
		param_email = "manoel@padaria.com"
		expected = "select * from user where email = '#{ param_email }';"
		result = query.search_user :email => param_email
		assert_equal(expected, result)
	end

	def test_search_user_security_email
		query = BuildQuery.new
		param_email_hack = "manoel@padaria.com'; Drop Table user; --"
		param_email = "manoel@padaria.com\\'; Drop Table user; --"
		expected = "select * from user where email = '#{ param_email }';"
		result = query.search_user :email => param_email_hack
		assert_equal(expected, result)
	end

	def test_search_user_name_and_email
		query = BuildQuery.new
		param_name_hack = "manoel'; Drop Table user; --"
		param_name = "manoel\\'; Drop Table user; --"

		param_email_hack = "manoel@padaria.com'; Drop Table user; --"
		param_email = "manoel@padaria.com\\'; Drop Table user; --"

		expected = "select * from user where name = '#{ param_name }' and email = '#{param_email}';"
		result = query.search_user :name => param_name_hack, :email => param_email_hack
		assert_equal(expected, result)
	end

	def test_search_user_name_and_email_cpf
		query = BuildQuery.new
		param_name_hack = "manoel'; Drop Table user; --"
		param_name = "manoel\\'; Drop Table user; --"

		param_email_hack = "manoel@padaria.com'; Drop Table user; --"
		param_email = "manoel@padaria.com\\'; Drop Table user; --"

		param_cpf_hack = "001.914.323-00'; Drop Table user; --"
		param_cpf = "001.914.323-00\\'; Drop Table user; --"

		expected = "select * from user where name = '#{ param_name }' and email = '#{param_email}' and cpf = '#{param_cpf}';"
		result = query.search_user :name => param_name_hack, :email => param_email_hack, :cpf => param_cpf_hack
		assert_equal(expected, result)
	end

	def test_search_user_email_cpf_name
		query = BuildQuery.new
		param_name_hack = "manoel'; Drop Table user; --"
		param_name = "manoel\\'; Drop Table user; --"

		param_email_hack = "manoel@padaria.com'; Drop Table user; --"
		param_email = "manoel@padaria.com\\'; Drop Table user; --"

		param_cpf_hack = "001.914.323-00'; Drop Table user; --"
		param_cpf = "001.914.323-00\\'; Drop Table user; --"

		expected = "select * from user where email = '#{param_email}' and cpf = '#{param_cpf}' and name = '#{ param_name }';"
		result = query.search_user :email => param_email_hack, :cpf => param_cpf_hack, :name => param_name_hack
		assert_equal(expected, result)
	end
end



