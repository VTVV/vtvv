module ProfileData
  extend ActiveSupport::Concern
  def profile_params
    params.require(:profile).permit(:first_name,
                                    :last_name,
                                    :sex,
                                    :home_phone,
                                    :mobile_phone,
                                    :company_name,
                                    :job_position,
                                    :nationality,
                                    :credit_number,
                                    :address,
                                    :salary,
                                    :family_status,
                                    :birth_date, :passport)
  end
end
