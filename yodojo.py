from unittest import TestCase, main


def search(name=None, email=None):

	where = ""
	if email:
		email = email.replace("'", r"\'")
		where = "WHERE email='" + email + "'"
	if name:
		name = name.replace("'", r"\'")
		where = "WHERE name='" + name + "'"
	return "SELECT * FROM user " + where + ";"

def formata_parametro(nome_parametro, valor_parametro):
	nome_parametro = nome_parametro.replace("'", r"\'")
	return "WHERE " + nome_parametro + "='" + valor_parametro + "'"

class SearchTest(TestCase):
	def test_all(self):
		sql = "SELECT * FROM user ;"
		self.assertEqual(sql, search())

	def test_name(self):
		sql = "SELECT * FROM user WHERE name='Lauro';"
		self.assertEqual(sql, search(name="Lauro"))

	def test_any_name(self):
		sql = r"SELECT * FROM user WHERE name='Henrique\'; DROP TABLE user ;';"
		self.assertEqual(sql, search(name="Henrique'; DROP TABLE user ;"))

	def test_email(self):
		sql = "SELECT * FROM user WHERE email='user@email.com';"
		self.assertEqual(sql, search(email="user@email.com"))

	def test_any_email(self):
		sql= r"SELECT * FROM user WHERE email='user@email.com\'; DROP TABLE user ;';"
		self.assertEqual(sql, search(email="user@email.com'; DROP TABLE user ;"))



#select * from user where name = 'Henrique'; Drop Table user; '


main()