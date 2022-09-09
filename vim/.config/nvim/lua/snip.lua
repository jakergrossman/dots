return 
{
  c = {
    dp = 'fprintf(stderr, "${=time()}")} $0\\n");',
    inc = '#include <$0>',
    qinc = '#include "$0"',
    guard = [[
#ifndef ${1:guard}
#define $1

$0

#endif
]];
  };

  cpp = {
    coutn = 'std::cout << $0 << std::endl;',
    cout = 'std::cout << $0;',
    inc = '#include <$0>',
    qinc = '#include "$0"',
    dp = 'std::cerr << "${=time()} " << $0 << std::endl;',
    guard = [[
#ifndef ${1:guard}
#define $1

$0

#endif
]];
  };

  javascript = {
    dp = 'console.log("${=time()} $0");'
  }
}
