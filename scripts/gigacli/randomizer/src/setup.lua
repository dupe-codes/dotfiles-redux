local version = _VERSION:match("%d+%.%d+")

package.path = "lua_modules/share/lua/"
	.. version
	.. "/?.lua;lua_modules/share/lua/"
	.. version
	.. "/?/init.lua;"
	.. "src/?.lua;"
	.. "src/?/init.lua;"
	.. package.path
package.cpath = "lua_modules/lib/lua/" .. version .. "/?.so;" .. package.cpath
