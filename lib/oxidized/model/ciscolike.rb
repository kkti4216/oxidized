class CISCOLIKE < Oxidized::Model
    prompt /([\w.@()-]+[#>]\s?)$/
    comment '! '

    cmd :all do |cfg|
      cfg.each_line.to_a[2..-2].join
    end

    cmd 'show version | exclude uptime|system' do |cfg|
      comment cfg
    end

    cmd 'show running-config' do |cfg|
      cfg = cfg.each_line.to_a[3..-1].join
      cfg
    end

    cfg :telnet do
      username /[Ll]ogin:|[Uu]sername:/
      password /[pP]assword:/
    end

    cfg :telnet, :ssh do
      post_login 'terminal length 0'
      pre_logout 'exit'
    end
  end
