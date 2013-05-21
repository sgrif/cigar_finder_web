namespace :cigars do
  task :confirm => :environment do
    unconfirmed_cigars = CigarSearchLog.all_cigars - ConfirmedCigar.pluck(:name)
    unconfirmed_cigars.each do |cigar|
      begin
        print "\nIs #{cigar} a real cigar? [Ynq]"
        result = $stdin.gets.squish.downcase
      end until ['y', 'n', 'q', ''].include?(result)

      case result
      when 'y', ''
        ConfirmedCigar.confirm(cigar)
      when 'n'
        CigarSearchLog.where(cigar: cigar).delete_all
        CigarStock.where(cigar: cigar).delete_all
      when 'q'
        exit
      end
    end
  end
end
