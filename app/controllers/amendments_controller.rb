class AmendmentsController < InheritedResources::Base

  private

    def amendment_params
      params.require(:amendment).permit(:number, :type, :explanation, :user_id, :budget_id)
    end

end
