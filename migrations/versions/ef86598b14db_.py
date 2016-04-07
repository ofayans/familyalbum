"""empty message

Revision ID: ef86598b14db
Revises: 5b7bd7bc2404
Create Date: 2016-04-02 21:53:22.312768

"""

# revision identifiers, used by Alembic.
revision = 'ef86598b14db'
down_revision = '5b7bd7bc2404'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.add_column('photo', sa.Column('large_thumbnail_path', sa.Unicode(), nullable=True))
    op.add_column('photo', sa.Column('small_thumbnail_path', sa.Unicode(), nullable=True))
    op.drop_constraint('spouses_rightspouse_id_fkey', 'spouses', type_='foreignkey')
    op.drop_constraint('spouses_leftspouse_id_fkey', 'spouses', type_='foreignkey')
    op.create_foreign_key(None, 'spouses', 'person', ['rightspouse_id'], ['id'], ondelete='CASCADE')
    op.create_foreign_key(None, 'spouses', 'person', ['leftspouse_id'], ['id'], ondelete='CASCADE')
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'spouses', type_='foreignkey')
    op.drop_constraint(None, 'spouses', type_='foreignkey')
    op.create_foreign_key('spouses_leftspouse_id_fkey', 'spouses', 'person', ['leftspouse_id'], ['id'])
    op.create_foreign_key('spouses_rightspouse_id_fkey', 'spouses', 'person', ['rightspouse_id'], ['id'])
    op.drop_column('photo', 'small_thumbnail_path')
    op.drop_column('photo', 'large_thumbnail_path')
    ### end Alembic commands ###