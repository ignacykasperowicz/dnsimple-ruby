require 'dnsimple/command'

module DNSimple
  module Commands
    class AddService < Command
      def execute(args, options={})
        domain_name = args.shift
        domain = Domain.find(domain_name)
        short_name = args.shift
        service = Service.find(short_name)
        domain.add_service(short_name)
        say "Added #{service.name} to #{domain_name}"
      end
    end
  end
end
