module CompilerHelper
  COMPILER_LIST = [
    ["language-cpp", ".cpp", "C++ 17 / GNU C++ Compiler 11.2.0 | -O2 -std=c++17", "c++17"],
    ["language-cpp", ".cpp", "C++ 20 / GNU C++ Compiler 11.2.0 | -O2 -std=c++20", "c++20"],
    ["language-cpp", ".cpp", "C++ 23 / GNU C++ Compiler 16.1.0 | -O2 -std=c++23", "c++23"],
    ["language-cpp", ".cpp", "C++ 26 / GNU C++ Compiler 16.1.0 | -O2 -std=c++26", "c++26"],
    ["language-cpp", ".cpp", "C++ 14 / GNU C++ Compiler 11.2.0 | -O2 -std=c++14", "c++14"],
    ["language-cpp", ".cpp", "C++ 11 / GNU C++ Compiler 11.2.0 | -O2 -std=c++11", "c++11"],
    ["language-cpp", ".cpp", "C++ 98 / GNU C++ Compiler 11.2.0 | -O2 -std=c++98", "c++98"],
    ["language-c", ".c", "C 17 / GNU C Compiler 11.2.0 | -O2 -std=c17 -lm", "c17"],
    ["language-c", ".c", "C 11 / GNU C Compiler 11.2.0 | -O2 -std=c11 -lm", "c11"],
    ["language-c", ".c", "C 99 / GNU C Compiler 11.2.0 | -O2 -std=c99 -lm", "c99"],
    ["language-c", ".c", "C 90 / GNU C Compiler 11.2.0 | -O2 -ansi -lm", "c90"],
    ["language-rustc", ".rs", "Rust / rustc", "rustc"],
    ["language-ts", ".ts", "TypeScript / ESBuild 0.25.5 + Node 24.1.0 | --platform=node --format=cjs", "typescript"],
    ["language-java", ".java", "Java / Azul Zulu OpenJDK 25.0.3", "java"],
    ["language-python", ".py", "Python 3 / CPython 3.10.4 with numpy & PIL | -m py_compile", "python3"],
    ["language-python", ".py", "Python 2 (Deprecated) / CPython 2.7.18 | -m py_compile", "python2"],
    ["language-haskell", ".hs", "Haskell / glasgow haskell compiler 8.8.4 with haskell platform | -O", "haskell"],
  ]

  def self.generate_table
    to_delete = Compiler.all.map{|x| x.name}.to_a - COMPILER_LIST.map{|x| x[3]}.to_a
    Compiler.where(name: to_delete).destroy_all
    to_update = COMPILER_LIST.map.with_index{|x, index|
      {name: x[3], description: x[2], format_type: x[0], extension: x[1], order: index}
    }
    Compiler.import(to_update, on_duplicate_key_update: [:description, :format_type, :extension, :order])
  end
  def generate_table
    CompilerHelper.generate_table
  end
end
