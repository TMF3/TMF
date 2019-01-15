#include <string>
#include <vector>
#include <cctype>
#include <iterator>
#include <algorithm>
#include <iomanip>
#include <sstream>
#include <ctime>
#include <time.h>
#include <chrono>

#define CURRENT_VERSION "1.0.0.0"

extern "C" {
	__declspec (dllexport) void __stdcall RVExtensionVersion(char *output, int outputSize);
	__declspec (dllexport) void __stdcall RVExtension(char *output, int outputSize, const char *function);
	__declspec (dllexport) int __stdcall RVExtensionArgs(char *output, int outputSize, const char *function, const char **args, int argsCnt);
}

void __stdcall RVExtensionVersion(char *output, int outputSize) {
	strncpy_s(output, outputSize, CURRENT_VERSION, _TRUNCATE);
}

void __stdcall RVExtension(char *output, int outputSize, const char *function) {
	std::string msg = "USE ARRAY SYNTAX! http://teamonetactical.com/wiki/doku.php?id=tmf:systemtime_extension";
	strncpy_s(output, outputSize, msg.c_str(), _TRUNCATE);
}

int __stdcall RVExtensionArgs(char *output, int outputSize, const char *function, const char **args, int argsCnt) {
	try {
		std::string param0 = "";
		bool param0_isnumber;

		if (argsCnt >= 1) {
			param0 = args[0];
			if (param0.length() >= 2) {
				if (param0.front() == '\"' && param0.back() == '\"')
					param0 = param0.substr(1, param0.length() - 2);
			}
		}
		
		param0_isnumber = (param0.empty()) ? true : std::all_of(param0.begin(), param0.end(), [](char c) { return std::isdigit(c); });

		if (param0_isnumber) {
			int time_offset = (param0.empty()) ? 0 : std::stoi(param0);
			long int time_now = static_cast<long int> (std::time(nullptr));

			snprintf(output, outputSize, "%d", time_now - time_offset);
			output[outputSize - 1] = '\0';

			return 1001;
		} else {
			std::string param1 = "";
			bool param1_isnumber;

			if (argsCnt >= 2) {
				param1 = args[1];
				if (param1.length() >= 2) {
					if (param1.front() == '\"' && param1.back() == '\"')
						param1 = param1.substr(1, param1.length() - 2);
				}
			}
				
			param1_isnumber = (param1 == "") ? false : std::all_of(param1.begin(), param1.end(), [](char c) { return std::isdigit(c); });

			std::time_t t;
			if (param1_isnumber) {
				std::chrono::seconds secs(std::stoi(param1));
				std::chrono::time_point<std::chrono::system_clock> timep(secs);
				t = std::chrono::system_clock::to_time_t(timep);
			} else {
				t = std::time(nullptr);
			}

			std::tm timeinfo;
			localtime_s(&timeinfo, &t);
			std::stringstream time_sstr;
			time_sstr << std::put_time(&timeinfo, param0.c_str());
			std::string str = time_sstr.str();

			snprintf(output, outputSize, str.c_str());
			output[outputSize - 1] = '\0';

			if (param1_isnumber)
				return 1002;
			return 1003;
		}
	} catch (...) {
		std::string msg = "Exception caught: arguments: [";
		if (argsCnt >= 1) {
			msg += args[0];

			if (argsCnt >= 2) {
				msg += ", ";
				msg += args[1];
			}
		}
		msg += "]";

		strncpy_s(output, outputSize, msg.c_str(), _TRUNCATE);
		return 201;
	}
}