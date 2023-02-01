class FOUNDRY < Oxidized::Model
    prompt /([\w.@()-]+[#>]\s?)$/
    comment '! '

    cmd :all do |cfg|
      cfg.each_line.to_a[2..-2].join
    end

    cmd 'show version | exclude system' do |cfg|
      comment cfg
    end

    cmd 'show running-config' do |cfg|
      cfg = cfg.each_line.to_a[3..-1].join
      cfg
    end

    cfg :telnet do
      username /^Please Enter Login Name:/
      password /^Please Enter Password:Please Enter Password:/
    end

    cfg :telnet, :ssh do
      post_login 'terminal length 0'
      pre_logout 'exit'
    end
  end
