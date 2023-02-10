class RGOS < Oxidized::Model
# Ruijie
# ver11.0
    prompt /([\w.@()-]+[#>]\s?)$/
    comment '! '

    cmd :all do |cfg|
      cfg.each_line.to_a[2..-2].join
    end

    cmd 'show version' do |cfg|
      comment cfg
    end

    cmd 'show current-config' do |cfg|
      cfg = cfg.each_line.to_a[3..-1].join
      cfg
    end

    cfg :telnet do
      username /Username:/
      password /Password:/
    end

    cfg :telnet, :ssh do
      post_login do
        if vars(:enable) == true
          cmd "enable"
        elsif vars(:enable)
          cmd "enable", /^[pP]assword:/
          cmd vars(:enable)
        end
      end
      post_login 'terminal length 0'
      pre_logout 'exit'
    end
  end
