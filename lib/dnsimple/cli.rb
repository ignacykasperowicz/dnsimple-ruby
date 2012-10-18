module DNSimple

  class CommandNotFound < RuntimeError
  end

  class CLI

    def execute(command_name, args, options={})
      DNSimple::Client.load_credentials_if_necessary
      command = commands[command_name]
      if command
        begin
          command.new.execute(args, options)
        rescue DNSimple::Error => e
          puts "An error occurred: #{e.message}"
        rescue RuntimeError => e
          puts "An error occurred: #{e.message}"
        end
      else
        raise CommandNotFound, "Unknown command: #{command_name}"
      end
    end

    def commands
      {
        'info' => DNSimple::Commands::DescribeUser,

        'check' => DNSimple::Commands::CheckDomain,
        'create' => DNSimple::Commands::CreateDomain,
        'register' => DNSimple::Commands::RegisterDomain,
        'transfer' => DNSimple::Commands::TransferDomain,
        'describe' => DNSimple::Commands::DescribeDomain,
        'list' => DNSimple::Commands::ListDomains,
        'delete' => DNSimple::Commands::DeleteDomain,
        'clear' => DNSimple::Commands::ClearDomain,
        'apply' => DNSimple::Commands::ApplyTemplate,
        
        'membership:add' => DNSimple::Commands::MembershipAdd,
        'membership:delete' => DNSimple::Commands::MembershipDelete,
        'membership:list' => DNSimple::Commands::MembershipList,

        'record:describe' => DNSimple::Commands::DescribeRecord,
        'record:create' => DNSimple::Commands::CreateRecord,
        'record:list' => DNSimple::Commands::ListRecords,
        'record:update' => DNSimple::Commands::UpdateRecord,
        'record:delete' => DNSimple::Commands::DeleteRecord,

        'template:create' => DNSimple::Commands::CreateTemplate,
        'template:list' => DNSimple::Commands::ListTemplates,
        'template:delete' => DNSimple::Commands::DeleteTemplate,

        'template:list_records' => DNSimple::Commands::ListTemplateRecords,
        'template:add_record' => DNSimple::Commands::AddTemplateRecord,
        'template:delete_record' => DNSimple::Commands::DeleteTemplateRecord,

        'contact:create' => DNSimple::Commands::CreateContact,
        'contact:list' => DNSimple::Commands::ListContacts,
        'contact:describe' => DNSimple::Commands::DescribeContact,
        'contact:update' => DNSimple::Commands::UpdateContact,
        'contact:delete' => DNSimple::Commands::DeleteContact,

        'extended-attributes:list' => DNSimple::Commands::ListExtendedAttributes,

        'service:list' => DNSimple::Commands::ListServices,
        'service:describe' => DNSimple::Commands::DescribeService,

        'service:applied' => DNSimple::Commands::ListAppliedServices,
        'service:available' => DNSimple::Commands::ListAvailableServices,
        'service:add' => DNSimple::Commands::AddService,
        'service:remove' => DNSimple::Commands::RemoveService,

        'certificate:list' => DNSimple::Commands::ListCertificates,
        'certificate:describe' => DNSimple::Commands::DescribeCertificate,
        'certificate:purchase' => DNSimple::Commands::PurchaseCertificate,
        'certificate:submit' => DNSimple::Commands::SubmitCertificate
      }
    end
  end
end

require 'dnsimple/commands/describe_user'
require 'dnsimple/commands/check_domain'
require 'dnsimple/commands/create_domain'
require 'dnsimple/commands/register_domain'
require 'dnsimple/commands/transfer_domain'
require 'dnsimple/commands/describe_domain'
require 'dnsimple/commands/list_domains'
require 'dnsimple/commands/delete_domain'
require 'dnsimple/commands/clear_domain'
require 'dnsimple/commands/apply_template'
require 'dnsimple/commands/membership_add'
require 'dnsimple/commands/membership_delete'
require 'dnsimple/commands/membership_list'

require 'dnsimple/commands/describe_record'
require 'dnsimple/commands/create_record'
require 'dnsimple/commands/list_records'
require 'dnsimple/commands/update_record'
require 'dnsimple/commands/delete_record'

require 'dnsimple/commands/create_template'
require 'dnsimple/commands/list_templates'
require 'dnsimple/commands/delete_template'
require 'dnsimple/commands/list_template_records'
require 'dnsimple/commands/add_template_record'
require 'dnsimple/commands/delete_template_record'

require 'dnsimple/commands/create_contact'
require 'dnsimple/commands/list_contacts'
require 'dnsimple/commands/describe_contact'
require 'dnsimple/commands/update_contact'
require 'dnsimple/commands/delete_contact'

require 'dnsimple/commands/list_extended_attributes'

require 'dnsimple/commands/list_services'
require 'dnsimple/commands/describe_service'

require 'dnsimple/commands/list_available_services'
require 'dnsimple/commands/list_applied_services'
require 'dnsimple/commands/add_service'
require 'dnsimple/commands/remove_service'

require 'dnsimple/commands/list_certificates'
require 'dnsimple/commands/describe_certificate'
require 'dnsimple/commands/purchase_certificate'
require 'dnsimple/commands/submit_certificate'
