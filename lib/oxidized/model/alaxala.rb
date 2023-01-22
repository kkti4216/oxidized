class ALAXALA < Oxidized::Model
    prompt /([\w.@()-]+[#>]\s?)$/
    comment '! '

    # not possible to disable paging prior to show running-config
    # expect /^((.*)Others to exit ---(.*))$/ do |data, re|
    #   send 'a'
    #   data.sub re, ''
    # end

    cmd :all do |cfg|
      cfg.each_line.to_a[2..-2].join
    end

    cmd 'show version' do |cfg|
      comment cfg
    end

    cmd 'show running-config' do |cfg|
      cfg = cfg.each_line.to_a[3..-1].join
      cfg
    end

    cfg :telnet do
      username /^Username:/
      password /^Password:/
    end

    cfg :telnet, :ssh do
      # preferred way to handle additional passwords
      post_login do
        if vars(:enable) == true
          cmd "enable"
        elsif vars(:enable)
          cmd "enable", /^[pP]assword:/
          cmd vars(:enable)
        end
      end
      post_login 'set terminal pager disable'
      pre_logout 'exit'
    end
  end
