###

ownCloud - App Framework

@author Bernhard Posselt
@copyright 2012 Bernhard Posselt dev@bernhard-posselt.com

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE
License as published by the Free Software Foundation; either
version 3 of the License, or any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU AFFERO GENERAL PUBLIC LICENSE for more details.

You should have received a copy of the GNU Affero General Public
License along with this library.  If not, see <http://www.gnu.org/licenses/>.

###

describe '_UnequalQuery', ->


	beforeEach module 'OC'

	beforeEach inject (_UnequalQuery, _Model, _Query) =>
		@query = _UnequalQuery
		@q = _Query
		@model = _Model
		data1 =
			id: 3
			name: 'donovan'

		data2 =
			id: 5
			name: 'donOvan'

		data3 =
			id: 2
			name: 'jack'

		@data = [
			data1
			data2
			data3
		]


	it 'should be a _Query subclass', =>
		expect(new @query('id', 3) instanceof @q).toBe(true)


	it 'should have a correct hash', =>
		expect(new @query('id', 3).hashCode()).toBe('unequal_id_3_false')


	it 'should return an empty list on empty list', =>
		query = new @query('id', 3)
		expect(query.exec([]).length).toBe(0)


	it 'should query on one', =>
		query = new @query('name', 'donovan')

		expect(query.exec(@data)).toContain(@data[2])


	it 'should return a list with all elements if no element is equal', =>
		query = new @query('name', 5)

		expect(query.exec(@data).length).toBe(3)


	it 'should return a list with multiple entries if elements are unequal', =>
		query = new @query('name', 'jack')

		expect(query.exec(@data)).toContain(@data[0])
		expect(query.exec(@data)).toContain(@data[1])


	it 'should also provide a case insensitive options', =>
		query = new @query('name', 'donovan', true)

		expect(query.exec(@data)).not.toContain(@data[0])
		expect(query.exec(@data)).not.toContain(@data[1])
		expect(query.exec(@data)).toContain(@data[2])